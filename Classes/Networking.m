//
//  Networking.m
//  Heavy Accelerator
//
//  Created by Spencer Whyte on 10-01-11.
//
#import "Networking.h"
id yy;
@implementation Networking

static CFReadStreamRef input = NULL;
static CFWriteStreamRef output=NULL;
 void TCPServerAcceptCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
	if(type == kCFSocketAcceptCallBack){
		CFSocketNativeHandle nsh = *(CFSocketNativeHandle *)data;
		printf("Chicken %d\n\n\n", nsh);
		int t = accept(nsh, (struct sockaddr *)NULL, NULL);
		CFStreamCreatePairWithSocket(kCFAllocatorDefault, t, &input,&output);
		//CFReadStreamSetProperty(input, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
		//CFWriteStreamSetProperty(output, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
		CFSocketEnableCallBacks(socket, kCFSocketReadCallBack);
		CFSocketEnableCallBacks(socket, kCFSocketWriteCallBack);
		UInt8 buffer[1000];
		CFSocketContext socketCtxt = {0, NULL, NULL, NULL, NULL};
		CFSocketRef ct= CFSocketCreateWithNative(kCFAllocatorDefault, nsh, kCFSocketReadCallBack, (CFSocketCallBack)&TCPServerAcceptCallBack, &socketCtxt);
		CFRunLoopRef cfrl = CFRunLoopGetCurrent();
		CFRunLoopSourceRef source4 = CFSocketCreateRunLoopSource(kCFAllocatorDefault, ct, 0);
		CFRunLoopAddSource(cfrl, source4, kCFRunLoopCommonModes);
		CFRelease(source4);
		CFStreamCreatePairWithSocket(kCFAllocatorDefault, nsh, &input, &output);
       // [output writeData:[NSData dataWithBytes:"sweet" length:strlen("sweet")]];
	    int x= 68;
		//	printf("Getting write callbacks\n");
		//UInt8 buffer[4];
		float tempx = localPlayer.x;
		float tempz=  localPlayer.z;
		//float tempx = 69.0;
		//float tempz=  69.0;
		write(nsh,&tempx, 4);
		write(nsh,&tempz, 4);
	}
	 if(type ==kCFSocketReadCallBack){
		float x =0.0f;
		read(CFSocketGetNative(socket), &x, 4);
		float z=0.0f;
		read(CFSocketGetNative(socket), &z, 4);
		networkPlayer.x = x;
		 networkPlayer.z = z;
	//	printf("Reading %f",[yy car2].x );
	}
	if(type ==kCFSocketReadCallBack){
		//printf("Write\n");
		float tempx = localPlayer.x;
		float tempz=  localPlayer.z;
		write(CFSocketGetNative(socket),&tempx, 4);
		write(CFSocketGetNative(socket),&tempz, 4);	
	}
}

static void joinCallBack(CFSocketRef socket, CFSocketCallBackType type, CFDataRef address, const void *data, void *info) {
	if(type == kCFSocketAcceptCallBack){
		printf("Socket Accepted");
	}
	if(type ==kCFSocketReadCallBack){
		//printf("Read\n");
		float x =0.0f;
		read(CFSocketGetNative(socket), &x, 4);
		float z=0.0f;
		read(CFSocketGetNative(socket), &z, 4);
		//printf("%f   %f  \n",x,z);
		networkPlayer.x = x;
		networkPlayer.z = z;
	}
	
	if(type ==kCFSocketReadCallBack){
		//printf("Write\n");
		float tempx = localPlayer.x;
		float tempz=  localPlayer.z;
		write(CFSocketGetNative(socket),&tempx, 4);
		write(CFSocketGetNative(socket),&tempz, 4);	
	}
  //  printf("Joined the server\n");
}

-(id)init{
	if(self = [super init]){
		
	}
	yy = self;
	return self;
}


-(void)setServerName:(NSString*)serverName{
	serviceName = serverName;	
}

-(void)connect{
	NSNetService *temp = [[NSNetService alloc] initWithDomain:@"local." type:@"_halo3._tcp." name:@"Halo 3 Networking Beta"];
	[temp setDelegate:self];
	[temp resolveWithTimeout:10];
}

-(void)startServer{
	service = [[NSNetService alloc] initWithDomain:@"local." type:@"_halo3._tcp." name:@"Halo 3 Networking Beta" port:12345];
	[service publish];
	//- (id)initWithDomain:(NSString *)domain type:(NSString *)type name:(NSString *)name port:(int)port
	NSLog(@"%@", serviceName);
	printf("Starting the conenction process\n");
	struct sockaddr_in serverAddress;
	int listenfd, connectfd;
	if ( (listenfd = socket( PF_INET, SOCK_STREAM, 0 )) < 0 ) {
		perror( "socket" );
		exit(1);
	}
	
	bzero( &serverAddress, sizeof(serverAddress) );
	serverAddress.sin_family = PF_INET;
	serverAddress.sin_port = htons(12345);
	serverAddress.sin_addr.s_addr = htonl( INADDR_ANY );
	
	if ( bind( listenfd, (struct sockaddr *)&serverAddress, 
			  sizeof(serverAddress) ) < 0 ) {
		perror( "bind" );
		exit(1);
	}
	
	if ( listen( listenfd, 5 ) < 0 ) {
		perror( "listen" );
		exit(1);
	}
	printf("%d\n\n\n", listenfd);
	CFSocketContext socketCtxt = {0, self, NULL, NULL, NULL};
	CFSocketRef ct= CFSocketCreateWithNative(kCFAllocatorDefault, listenfd, kCFSocketAcceptCallBack, (CFSocketCallBack)&TCPServerAcceptCallBack, &socketCtxt);
	CFRunLoopRef cfrl = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source4 = CFSocketCreateRunLoopSource(kCFAllocatorDefault, ct, 0);
    CFRunLoopAddSource(cfrl, source4, kCFRunLoopCommonModes);
    CFRelease(source4);
	/*
	for (;;) {
		char *buffer = "Aidan sucks at programming\n";
		
		if ( (connectfd = accept( listenfd, 
								 (struct sockaddr *)NULL, NULL )) < 0 ) {
			perror( "accept" );
			exit(1);
		}
		
		if ( write( connectfd, buffer, strlen(buffer) ) < 0 ) {
			perror( "write" );
			exit(1);
		}
		
		close( connectfd );
	}
    */
	
	printf("Finished the connection process\n");
}



- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict{
printf("Unable to resolve the address\n");	
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender{
	
	int sockfd = socket( PF_INET, SOCK_STREAM, 0 );
	CFSocketContext socketCtxt = {0, self, NULL, NULL, NULL};
	connect( sockfd, [[[sender addresses] objectAtIndex:0] bytes], [[[sender addresses] objectAtIndex:0] length] );
	printf("\n%d\n\n\n", sockfd);
	CFSocketRef ct = CFSocketCreateWithNative(kCFAllocatorDefault, sockfd, kCFSocketReadCallBack, (CFSocketCallBack)&joinCallBack,  &socketCtxt);
	CFSocketEnableCallBacks(ct, kCFSocketReadCallBack);
	CFRunLoopRef cfrl = CFRunLoopGetCurrent();
    CFRunLoopSourceRef source4 = CFSocketCreateRunLoopSource(kCFAllocatorDefault, ct,0);
    CFRunLoopAddSource(cfrl, source4, kCFRunLoopCommonModes);
    CFRelease(source4);
	

}

- (void)netServiceWillResolve:(NSNetService *)sender{
	printf("Will Resolve");
}


- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing{
	 [netService setDelegate:self];
	printf("Started to wait");
	[netService resolveWithTimeout:10];
	printf("Started");
}


- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindDomain:(NSString *)domainName moreComing:(BOOL)moreDomainsComing{
	
}
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didNotSearch:(NSDictionary *)errorInfo{
	
}
- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)netService moreComing:(BOOL)moreServicesComing{
	
}
- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)netServiceBrowser{
	
}
- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)netServiceBrowser{
	
}



@end
