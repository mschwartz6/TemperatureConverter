//
//  ViewController.m
//  Temperature Converter
//
//  Created by alive on 9/29/17.
//  Copyright © 2017 Matthew Schwartz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *originalSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *convertedSegment;
@property (weak, nonatomic) IBOutlet UILabel *originalLabel;
@property (weak, nonatomic) IBOutlet UILabel *convertedLabel;
@property (weak, nonatomic) IBOutlet UISlider *changeTempSlider;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *origSubscriptLabel;
@property (weak, nonatomic) IBOutlet UILabel *convertSubscriptLabel;
-(double)tempConversion:(double)origTemp;
-(void)changeSliderRange;
-(void)displayTemps;
-(void)setScaleLabels;
-(void)setSubscriptLabels;
-(void)resetSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeSliderRange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)originalSegAction:(id)sender {
    
    self.originalLabel.text = @"-";
    self.convertedLabel.text=@"-";
    [self setScaleLabels];
    [self setSubscriptLabels];
    [self resetSlider];
}
- (IBAction)convertedSegAction:(id)sender {
    
    [self setSubscriptLabels];
    if ([[self.originalLabel text] isEqual:@"-"])
    {
        [self resetSlider];
        self.convertedLabel.text=@"-";
    }
    else
        [self displayTemps];
    
}
- (IBAction)changeTempSliderAction:(id)sender {
    
    
    [self displayTemps];
    
}
-(double)tempConversion:(double)origTemp
{
    double value = origTemp;
    int originalSegVal = (int)self.originalSegment.selectedSegmentIndex;
    
    
    switch (self.convertedSegment.selectedSegmentIndex){
                case 0://convert to fahrenheit
                    if (originalSegVal == 1)
                        value = value * 9/5 + 32;
                    else if (originalSegVal == 2)
                        value = value * 9/5 - 459.67;
                    break;
            
                case 1: //convert to celsius
                    if (originalSegVal == 0)
                        value = (value -32) * 5/9;
                    else if (originalSegVal == 2)
                        value = value - 273.15;
                    break;
            
                case 2://convert to kelvin
                    if (originalSegVal == 0)
                        value = (value + 459.67) * 5/9;
                    else if (originalSegVal == 1)
                        value =  value + 273.15;
                    break;
    }
            
    
    
    return value;
}
-(void)changeSliderRange
{
    switch (self.originalSegment.selectedSegmentIndex)
    {
        case 0:
            
            self.changeTempSlider.minimumValue = 32;
            self.changeTempSlider.maximumValue = 212;
            break;
        case 1:
            self.changeTempSlider.minimumValue = 0;
            self.changeTempSlider.maximumValue = 100;
            break;
        case 2:
            self.changeTempSlider.minimumValue = 273;
            self.changeTempSlider.maximumValue = 373;
            break;
    }
}
-(void)displayTemps
{
    [self changeSliderRange];
    double temp = (double)[self.changeTempSlider value];
    double val = [self tempConversion:temp];
    
    self.originalLabel.text = [NSString stringWithFormat:@"%.f",temp];
    
    if (self.originalSegment.selectedSegmentIndex == self.convertedSegment.selectedSegmentIndex)
        self.convertedLabel.text = @"-";
    else
        self.convertedLabel.text = [NSString stringWithFormat:@"%.f",val];
    
}
-(void)setScaleLabels
{
    switch (self.originalSegment.selectedSegmentIndex)
    {
        case 0:
            self.minLabel.text = @"32     F";
            self.maxLabel.text = @"212    F";
            break;
        case 1:
            self.minLabel.text = @"0      C";
            self.maxLabel.text = @"100    C";
            break;
        case 2:
            self.minLabel.text = @"273    K";
            self.maxLabel.text = @"373    K";
    }

}
-(void)setSubscriptLabels
{
    switch (self.originalSegment.selectedSegmentIndex)
    {
        case 0:
            self.origSubscriptLabel.text = @"F";
            break;
        case 1:
            self.origSubscriptLabel.text = @"C";
            break;
        case 2:
            self.origSubscriptLabel.text = @"K";
            break;
    }
    switch(self.convertedSegment.selectedSegmentIndex)
    {
        case 0:
            self.convertSubscriptLabel.text =@"F";
            break;
        case 1:
            self.convertSubscriptLabel.text =@"C";
            break;
        case 2:
            self.convertSubscriptLabel.text =@"K";
            break;
    }
}
-(void)resetSlider
{
    float min = [self.changeTempSlider minimumValue];
    float max = [self.changeTempSlider maximumValue];
    float reset = ((min + max) / 2 );
    self.changeTempSlider.value = reset;
}
@end
