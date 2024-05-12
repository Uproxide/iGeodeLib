#import <UIKit/UIKit.h>
#include <functional>
#include "iGeodeLib.hpp"

/*
very simple. converts NSString to std::string, although most functions here convert to char or std::string, this would probably come in handy in some situations.
usage:
auto str 
std::string NS2S(NSString *str) {
  return nsString ? [nsString UTF8String] : "";
}
*/
/*
  shows a system level alert.
  usage:
    showAlert("Insert title here", "insert message here...", "insert button here.");
  you cannot create a callback with this, use the showAlertWithCallback() function for callbacks.
*/
void showAlert(const char *title, const char *message, const char *Btn) {
  NSString *titleString = [NSString stringWithUTF8String:title];
  NSString *messageString = [NSString stringWithUTF8String:message];
  NSString *btnString = [NSString stringWithUTF8String:Btn];
    
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleString
                                                                            message:messageString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
  UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnString
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    
  [alertController addAction:okAction];

  UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

  [rootViewController presentViewController:alertController animated:YES completion:nil];
}

/*
  ShowAlert but with a function callback.
  usage:
  CShowAlert("Title", "Message", "go away", MyCoolFunction());
  - this function allows you to add 2 buttons!!!
  usage: (again)
  CShowAlert("Title", "Message", "go away", nullptr, "go away again", nullptr);
  this should give you an alert with 2 buttons and no callback at al!!!!;
  or alternatively
  CShowAlert("Title", "Message", "go away", nullptr, nullptr, nullptr);
  this should give you one button, with NO callback...
  you should probably use showAlert() instead for that.
*/ 

void CShowAlert(const char *title, const char *message, const char *Btn, std::function<void()> callback = nullptr, const char *Btn2 = nullptr, std::function<void()> callback2 = nullptr) {
  NSString *titleString = [NSString stringWithUTF8String:title];
  NSString *messageString = [NSString stringWithUTF8String:message];
  NSString *btnString = [NSString stringWithUTF8String:Btn];
    
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleString
                                                                            message:messageString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
  UIAlertAction *ButtonAction = [UIAlertAction actionWithTitle:btnString
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                    if (callback != nullptr) {
                                                      callback();
                                                    }
                                                   }];

    
  [alertController addAction:ButtonAction];
  
  if (Btn2 != nullptr) {
    NSString *btnString2 = [NSString stringWithUTF8String:Btn2];
    UIAlertAction *ButtonAction2 = [UIAlertAction ActionWithTitle:btnString2
                                                    style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                      if (callback2 != nullptr) {
                                                        callback2();
                                                      }
                                                    }];
    [alertController addAction:ButtonAction2];
  }

  UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

  [rootViewController presentViewController:alertController animated:YES completion:nil]; 
}

/* self explanatory, get the ios version.
  usage: iOSVersion();
  you can also do something like this
  if (iOSVersion == "17.4") {
    showAlert("iOS 17.4", "You are on iOS 17.4", "go away");
  } else {
    showAlert("Update Required", "Update to iOS 17.4", "shut up");
  }

  you might need to use the NS2S function on this to convert it to a std::string

*/
NSString* iOSVersion() {
  UIDevice *device = [UIDevice currentDevice];
  NSString *iOSVersion = [device systemVersion];
  return iOSVersion;
}