#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    NSError *error;
    NSString *str = @"こんにちは、世界！\n";

    // TODO: "/dev/stdout"が標準出力とならないWindowsシステムでは動作しない
    [str writeToFile:@"/dev/stdout"
          atomically:NO
          encoding:NSUTF8StringEncoding
             error:&error];
  }
  return 0;
}
