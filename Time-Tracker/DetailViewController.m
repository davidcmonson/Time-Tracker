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

@interface DetailViewController () <UITextFieldDelegate>

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

    self.dataSource.project = self.project;
    self.tableView.dataSource = self.dataSource;
    // Do any additional setup after loading the view from its nib.
    
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
    [self.project clockIn];
    [self.tableView reloadData];
}
- (IBAction)clockOutButton:(id)sender {
    [self.project clockOut];
    [self.tableView reloadData];
}
- (IBAction)reportButton:(id)sender {
}

#pragma mark - Delegate

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
