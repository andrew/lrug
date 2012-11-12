class TweetController < UIViewController
  def loadView
    self.view = UIView.new
  end
  
  def viewDidLoad
    self.view.backgroundColor = UIColor.blackColor
    init_label
  end
  
  def didRotateFromInterfaceOrientation(fromInterfaceOrientation)
    @label.frame = frame
  end
  
  def init_label
    @label = UILabel.alloc.initWithFrame(frame)
    @label.font = UIFont.boldSystemFontOfSize(30)
    @label.userInteractionEnabled = true
    @label.backgroundColor = BubbleWrap.rgba_color(0, 0, 0, 0)
    @label.lineBreakMode = UILineBreakModeWordWrap
    @label.numberOfLines = 0
    @label.color = '#fff'.to_color
    @label.text = "Hello #{hashtag}!      Tap me!"
    @label.addGestureRecognizer(single_tap)

    self.view.addSubview @label
  end
  
  def frame
    offset = 40
    [[offset,offset], [view.bounds.size.width - offset*2, view.bounds.size.height-offset*2]]
  end
  
  def single_tap
    UITapGestureRecognizer.alloc.initWithTarget(self, action: :'tapped:')
  end
  
  def hashtag
    'LRUG'
  end
  
  def tapped(sender)
    BW::HTTP.get("http://search.twitter.com/search.json?q=%23#{hashtag}") do |response|
      json = BW::JSON.parse(response.body.to_str)
      random_tweet = json['results'][rand(json['results'].length)]
      @label.text = random_tweet['text']
    end
  end
  
  def text_size
    constrain = CGSize.new(view.bounds.size.width, view.bounds.size.height)
    label_text.sizeWithFont(font, constrainedToSize:constrain)
  end
  
  def font
    font_size = view.bounds.size.width/3
    UIFont.boldSystemFontOfSize(font_size)
  end

  def label_text
    @label_text ||= 'hello'
  end
end