/* 
 * Copyright 2017 Christian-W. Budde
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
#import "CDVMailCore.h"

@implementation CDVMailCore

- (void)cordovaSendMail:(CDVInvokedUrlCommand*)command
{
	self.CallbackId = command.callbackId;

	NSDictionary* options = command.arguments[0];

	NSString *fromEmail = [options objectForKey:@"fromEmail"];
	NSString *toName = [options objectForKey:@"toName"];
	NSString *toEmail = [options objectForKey:@"toEmail"];
	NSString *bccEmail = [options objectForKey:@"bccEmail"];
	NSString *smtpServer = [options objectForKey:@"smtpServer"];
	int smtpPort = [[options objectForKey:@"smtpPort"] intValue];
	NSString *smtpUsername = [options objectForKey:@"smtpUserName"];
	NSString *smtpPassword = [options objectForKey:@"smtpPassword"];
	NSString *textBody = [options objectForKey:@"textBody"];

	CTCoreMessage *msg = [[CTCoreMessage alloc] init];
	CTCoreAddress *toAddress = [CTCoreAddress addressWithName:toName email:toEmail];
	[msg setTo:[NSSet setWithObject:toAddress]];
	[msg setBody: textBody];

	NSError *error;
	BOOL success = [CTSMTPConnection sendMessage:testMsg 
  	server:smtpServer
    username:smtpUsername
    password:smtpPassword
    port:smtpPort
    connectionType:CTSMTPConnectionTypeStartTLS
    useAuth:YES
    error:&error
	];

  if(success) {
    NSLog(@"Successfully sent email!");
		CDVPluginResult *pluginResult = [
			CDVPluginResult resultWithStatus : CDVCommandStatus_OK
		];				

		[self.commandDelegate sendPluginResult:pluginResult callbackId:self.CallbackId];
  } else {
    NSLog(@"Error sending email!");
		CDVPluginResult *pluginResult = [ 
			CDVPluginResult resultWithStatus: CDVCommandStatus_OK
		];

		[self.commandDelegate sendPluginResult:pluginResult callbackId:self.CallbackId];
    }
}

@end