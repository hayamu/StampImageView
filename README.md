StampImageView
==========

iOSでスタンプ画像を取り扱えます。
- 拡大・縮小
- 回転

------
<img src="http://github.one-pair.net/StampImageView/Image1.png" width="240px" style="width: 240px;"/>&nbsp;
<img src="http://github.one-pair.net/GitHub/StampImageView/Image2.png" width="240px" style="width: 240px;"/>&nbsp;
<img src="http://github.one-pair.net/GitHub/StampImageView/Image3.png" width="240px" style="width: 240px;"/>&nbsp;

## Usage

**Use view controller component**
```objective-c
    StampImageView *_stampImage = [[StampImageView alloc] init];
    [ _stampImage setBorderColor:0.3f color_g:0.3f color_b:0.7f ];
    [ _stampImage addStampImage : [UIImage imageNamed:@"Sample.png"] ];
    _stampImage.delegate = self;
    [ self.view addSubview: _stampImage ];
```

## System Requirement

**OS X 10.8 or later / iOS 6 or later**

## License

StampImageView is available under the MIT license. See the LICENSE file for more info.
