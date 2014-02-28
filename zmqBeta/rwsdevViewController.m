//
//  rwsdevViewController.m
//  zmqBeta
//
//  Created by Jason Becht on 2/28/14.
//  Copyright (c) 2014 RazorWire Solutions, Inc. All rights reserved.
//

#import "rwsdevViewController.h"

#define REQUEST_TIMEOUT     2500    //  msecs, (> 1000!)
#define REQUEST_RETRIES     3       //  Before we abandon
#define SERVER_ENDPOINT     "tcp://tacticalassassinationgame.com:6789"

@interface rwsdevViewController ()

@end

@implementation rwsdevViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self doStuff];
    
}
- (void)doStuff {
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    int rc = zmq_bind (responder, "tcp://tacticalassassinationgame.com:6789");
    assert (rc == 0);
    
    while (1) {
        char buffer [10];
        zmq_recv (responder, buffer, 10, 0);
        printf ("Received Hello\n");
        sleep (1);          //  Do some 'work'
        zmq_send (responder, "World", 5, 0);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
