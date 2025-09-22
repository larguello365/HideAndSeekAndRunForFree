//
//  Settings.m
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/6/25.
//

#import "Settings.h"

@interface Settings ()
@property (strong, nonatomic) IBOutlet UISwitch *readToMe;
@property (strong, nonatomic) IBOutlet UISwitch *automatic;
@property (strong, nonatomic) IBOutlet UISwitch *tapToPlay;
@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL readToMeOn = [defaults boolForKey:@"readToMe"];
    BOOL automaticOn = [defaults boolForKey:@"automatic"];
    BOOL tapToPlayOn = [defaults boolForKey:@"tapToPlay"];
    
    self.readToMe.on = readToMeOn;
    self.automatic.on = automaticOn;
    self.tapToPlay.on = tapToPlayOn;
    
    self.automatic.enabled = readToMeOn;
    self.tapToPlay.enabled = readToMeOn;
    
    [self.readToMe addTarget:self action:@selector(readToMeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.automatic addTarget:self action:@selector(automaticChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tapToPlay addTarget:self action:@selector(tapToPlayChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)readToMeChanged:(UISwitch *)sender {
    BOOL isOn = sender.isOn;
    
    self.automatic.enabled = isOn;
    self.tapToPlay.enabled = isOn;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isOn forKey:@"readToMe"];
    
    if (!isOn) {
        [self.automatic setOn:NO animated:YES];
        [self.tapToPlay setOn:NO animated:YES];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"automatic"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tapToPlay"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"UserDefaults — readToMe: %d, automatic: %d, tapToPlay: %d",
          [defaults boolForKey:@"readToMe"],
          [defaults boolForKey:@"automatic"],
          [defaults boolForKey:@"tapToPlay"]);
}

- (void)automaticChanged:(UISwitch *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.isOn) {
        [self.tapToPlay setOn:NO animated:YES];
        [defaults setBool:YES forKey:@"automatic"];
        [defaults setBool:NO forKey:@"tapToPlay"];
    } else {
        [defaults setBool:NO forKey:@"automatic"];
    }
    
    [defaults synchronize];
    
    NSLog(@"UserDefaults — readToMe: %d, automatic: %d, tapToPlay: %d",
          [defaults boolForKey:@"readToMe"],
          [defaults boolForKey:@"automatic"],
          [defaults boolForKey:@"tapToPlay"]);
}

- (void)tapToPlayChanged:(UISwitch *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (sender.isOn) {
        [self.automatic setOn:NO animated:YES];
        [defaults setBool:YES forKey:@"tapToPlay"];
        [defaults setBool:NO forKey:@"automatic"];
    } else {
        [defaults setBool:NO forKey:@"tapToPlay"];
    }
    
    [defaults synchronize];
    
    NSLog(@"UserDefaults — readToMe: %d, automatic: %d, tapToPlay: %d",
          [defaults boolForKey:@"readToMe"],
          [defaults boolForKey:@"automatic"],
          [defaults boolForKey:@"tapToPlay"]);
}

@end
