//
//  Networking.h
//  Heavy Accelerator
//
//  Created by Spencer Whyte on 10-01-11.
//

#import <Foundation/Foundation.h>
#include <CFNetwork/CFSocketStream.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include "LocalPlayer.h"
#include "NetworkPlayer.h"
LocalPlayer *localPlayer;
NetworkPlayer *networkPlayer;

@interface Networking : NSObject {
	NSString *serviceName;
	NSNetService *service;

}
@property LocalPlayer *localPlayer;
@property NetworkPlayer *networkPlayer;
-(void)setServerName:(NSString*)serverName;
-(void)startServer;
-(void)connect;
-(id)init;
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing;
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindDomain:(NSString *)domainName moreComing:(BOOL)moreDomainsComing;
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didNotSearch:(NSDictionary *)errorInfo;
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing;
- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)netServiceBrowser;
- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)netServiceBrowser;
- (void)netServiceDidResolveAddress:(NSNetService *)sender;
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict;
- (void)netServiceWillResolve:(NSNetService *)sender;
@end
