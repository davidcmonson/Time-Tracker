//
//  DetailViewController.m
//  Time-Tracker
//
//  Created by Jason Noah Choi on 2/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewDataSource.h"
#import "Project.h"
#import "CustomEntryViewController.h"
#import <MessageUI/MessageUI.h>
#import "ProjectController.h"
#import "WorkPeriods.h"

static NSString * const EntryKey = @"entry";

@interface DetailViewController () <UITextFieldDelegate, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) DetailTableViewDataSource *dataSource;

@end

@implementation DetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [DetailTableViewDataSource new];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project = [Project new];
    self.dataSource.project = self.project;
    self.tableView.dataSource = self.dataSource;
    self.timeLabel.text = [self.project time];
    self.titleTextField.text = self.project.title;
    self.titleTextField.delegate = self;
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons

- (IBAction)addButton:(id)sender {
    CustomEntryViewController *customEntryVC = [CustomEntryViewController new];
    customEntryVC.project = self.project;
    [self presentViewController:customEntryVC animated:YES completion:nil];
    
}
- (IBAction)clockInButton:(id)sender {
    Project *project = [[Project alloc] init];
    
//    [[ProjectController sharedInstance] replaceOldProject:self.project withNewProject:project];
//        
//    NSInteger lastRow = [[ProjectController sharedInstance].projects indexOfObject:project];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    [self.project clockIn];

}

- (IBAction)clockOutButton:(id)sender {
    [self.project clockOut];
    [self.tableView reloadData];
    
    WorkPeriods *entry = [WorkPeriods new];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", entry.clockOut];
}
- (IBAction)reportButton:(id)sender {
    MFMailComposeViewController *mailCompose = [MFMailComposeViewController new];
    NSString *times;
    for (WorkPeriods *entry in self.project.entries) {
        times = [NSString stringWithFormat:@"%@ \n %@", entry.clockIn, entry.clockOut];
    }
    [mailCompose setMessageBody:times isHTML:YES];
    [self presentViewController:mailCompose animated:YES completion:nil];
}

#pragma mark - Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.text = self.titleTextField.text;
    self.title = textField.text;
    return YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
