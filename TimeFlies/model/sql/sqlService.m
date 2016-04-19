//
//  sqlService.m
//  TimeFlies
//
//  Created by 林伟池 on 16/4/14.
//  Copyright © 2016年 林伟池. All rights reserved.
//

#import "sqlService.h"


@implementation sqlService

@synthesize _database;

- (id)init
{
    return self;
}

- (void)dealloc
{
}

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    return [documentsDirectory stringByAppendingPathComponent:@"data.db"];//这里可以定义成任何类型的文件，也可以不定义成.db文件
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开，如果数据库不存在sqlite3_open会自动创建
    if (find) {
        
        NSLog(@"Database file have already existed.");
        
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
            NSLog(@"Error: open database file.");
            return NO;
        }
        
        //创建一个新表
        [self createTestList:self._database];
        
        return YES;
    }
    //如果发现数据库不存在则利用sqlite3_open创建数据库（上面已经提到过），与上面相同，路径要转换为C字符串
    if(sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        //创建一个新表
        [self createTestList:self._database];
        return YES;
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(self._database);
        NSLog(@"Error: open database file.");
        return NO;
    }
    return NO;
}

//创建表
- (BOOL) createTestList:(sqlite3*)db {
    
    //这句是大家熟悉的SQL语句
    char *sql = "create table if not exists testTable(ID INTEGER PRIMARY KEY AUTOINCREMENT, testID int,testValue text,testName text)";// testID是列名，int 是数据类型，testValue是列名，text是数据类型，是字符串类型
    
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement结构里去. 使用该接口访问数据库是当前比较好的的一种方法
    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
    //第一个参数跟前面一样，是个sqlite3 * 类型变量，
    //第二个参数是一个 sql 语句。
    //第三个参数我写的是-1，这个参数含义是前面 sql 语句的长度。如果小于0，sqlite会自动计算它的长度（把sql语句当成以\0结尾的字符串）。
    //第四个参数是sqlite3_stmt 的指针的指针。解析以后的sql语句就放在这个结构里。
    //第五个参数是错误信息提示，一般不用,为nil就可以了。
    //如果这个函数执行成功（返回值是 SQLITE_OK 且 statement 不为NULL ），那么下面就可以开始插入二进制数据。
    
    
    //如果SQL语句解析出错的话程序返回
    if(sqlReturn != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create test table");
        return NO;
    }
    
    //执行SQL语句
    int success = sqlite3_step(statement);
    //释放sqlite3_stmt
    sqlite3_finalize(statement);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        NSLog(@"Error: failed to dehydrate:create table test");
        return NO;
    }
    return YES;
}

//插入数据
-(BOOL) insertTestList:(sqlTestList *)insertList {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        const char* sql = [[NSString stringWithFormat:@"INSERT INTO testTable(testID, testValue,testName) VALUES(%d, \"%@\", \"%@\")", insertList.sqlID, insertList.sqlText, insertList.sqlname] UTF8String];
        
        const char* sqlOther = "INSERT INTO testTable(testID, testValue,testName) VALUES(?, ?, ?)";
        sql = sqlOther;
        
        int success2 = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success2 != SQLITE_OK) {
            NSLog(@"Error: failed to insert:testTable SQL:%s", sql);
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_bind_int(statement, insertList.sqlID, 1);
        sqlite3_bind_text(statement, 2, insertList.sqlText.UTF8String, -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, insertList.sqlname.UTF8String, -1, SQLITE_TRANSIENT);
        
        //执行插入语句
        success2 = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果插入失败
        if (success2 == SQLITE_ERROR) {
            NSLog(@"Error: failed to insert into the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//获取数据
- (NSMutableArray*)getTestList{
    
    NSMutableArray *array = [NSMutableArray array];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT testID, testValue ,testName FROM testTable";//从testTable这个表中获取 testID, testValue ,testName，若获取全部的话可以用*代替testID, testValue ,testName。
        
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:get testValue.");
            return nil;
        }
        else {
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值，跟上面sqlite3_bind_text绑定的列值不一样！一定要分开，不然会crash，只有这一处的列号不同，注意！
            while (sqlite3_step(statement) == SQLITE_ROW) {
                sqlTestList* sqlList = [[sqlTestList alloc] init] ;
                sqlList.sqlID    = sqlite3_column_int(statement,0);
                char* strText   = (char*)sqlite3_column_text(statement, 1);
                sqlList.sqlText = [NSString stringWithUTF8String:strText];
                char *strName = (char*)sqlite3_column_text(statement, 2);
                sqlList.sqlname = [NSString stringWithUTF8String:strName];
                [array addObject:sqlList];
  
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array;
}

//更新数据
-(BOOL) updateTestList:(sqlTestList *)updateList{
    
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update testTable set testValue = ? and testName = ? WHERE testID = ?";
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to update:testTable");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_text(statement, 3, [updateList.sqlname UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [updateList.sqlText UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 1, updateList.sqlID);
        
        //执行SQL语句
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to update the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}
//删除数据
- (BOOL) deleteTestList:(sqlTestList *)deletList{
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete from testTable  where testID = ? and testValue = ? and testName = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to delete:testTable");
            sqlite3_close(_database);
            return NO;
        }
        
        sqlite3_bind_int(statement, 1, deletList.sqlID);
        sqlite3_bind_text(statement, 2, [deletList.sqlText UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [deletList.sqlname UTF8String], -1, SQLITE_TRANSIENT);
        //执行SQL语句。
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
    
}
//查询数据
- (NSMutableArray*)searchTestList:(NSString*)searchString{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * from testTable where testName like \"%@\"",searchString];
        const char *sql = [querySQL UTF8String];

        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search testValue.");
            return nil;
        } else {
            sqlite3_bind_text(statement, 3, [searchString UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                sqlTestList* sqlList = [[sqlTestList alloc] init] ;
                sqlList.sqlID   = sqlite3_column_int(statement,1);
                char* strText   = (char*)sqlite3_column_text(statement, 2);
                sqlList.sqlText = [NSString stringWithUTF8String:strText];
                char *strName = (char*)sqlite3_column_text(statement, 3);
                sqlList.sqlname = [NSString stringWithUTF8String:strName];
                [array addObject:sqlList];
      
            }
     
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array;
}

@end


@implementation sqlTestList

@synthesize sqlID;
@synthesize sqlText;
@synthesize sqlname;
-(id) init
{
    sqlID = 0;
    sqlText = @"";
    sqlname = @"";
    return self;
}

- (instancetype)initWithID:(int)number Text:(NSString *)text Name:(NSString *)name {
    self = [super init];
    self.sqlID = number;
    self.sqlText = text;
    self.sqlname = name;
    
    return self;
}
-(void) dealloc
{
    if ((sqlText != nil) && (sqlname != nil)) {
        sqlText = nil;
        sqlname = nil;
    }
}

@end
