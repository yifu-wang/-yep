//
//  MineTableViewCell.m
//  HealthyDiet
//
//  Created by ByteDance on 2024/3/25.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.headView];
    }
    
    return self;
}

-(UILabel *)nameLabel
{
    
    if(_nameLabel == nil){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 40)];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _nameLabel;
}

-(UIImageView *)headView
{
    
    if(_headView == nil){
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
    }
    
    return _headView;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
