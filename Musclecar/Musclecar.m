//
//  Musclecar.m
//  Musclecar
//
//  Created by Wolfgang Baird on 10/15/19.
//Copyright © 2019 Wolfgang Baird. All rights reserved.
//

#import "Musclecar.h"

@interface Musclecar()
@end

@interface MusclecarDevice : NSObject
@end

@implementation MusclecarDevice

- (id)initWithIdentifier:(id)arg1 model:(id)arg2 name:(id)arg3 version:(id)arg4 {
    
    NSArray *unsupportedModels = @[@"iPad4,1", @"iPad4,2", @"iPad4,3", @"iPad4,4", @"iPad4,5", @"iPad4,6", @"iPad4,7", @"iPad4,8", @"iPad4,9", @"iPad5,1", @"iPad5,2", @"iPad5,3", @"iPad5,4", @"iPad6,11", @"iPad6,12"];
    
    // Null the model to just iPad
    if ([unsupportedModels containsObject:arg2]) arg2 = @"iPad";
    
    // Init the device
    SidecarDevice *mc = ZKOrig(id, arg1, arg2, arg3, arg4);

    // Log
//    NSLog(@"Musclecar : %@", mc.model);
    
    // Return the device
    return (MusclecarDevice*)mc;
}

@end

@implementation Musclecar

+ (instancetype)sharedInstance {
    static Musclecar *plugin = nil;
    @synchronized(self) {
        if (!plugin) {
            plugin = [[self alloc] init];
        }
    }
    return plugin;
}

+ (void)load {
//    Musclecar *plugin = [Musclecar sharedInstance];
    ZKSwizzle(MusclecarDevice, SidecarDevice);
    NSUInteger osx_ver = [[NSProcessInfo processInfo] operatingSystemVersion].minorVersion;
    NSLog(@"%@ loaded into %@ on macOS 10.%ld", [self class], [[NSBundle mainBundle] bundleIdentifier], (long)osx_ver);
}


@end
