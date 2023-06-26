
![](http://dongjia-oss.oss-cn-beijing.aliyuncs.com/blog/SpanFloatLayout-2023-06-26-11-23-53.png)


# SnapFloatLayout

### 布局方案效率神器!  一套布局代码应对多种业务场景!!!

#### [ SnapFloatLayout 基于 SnapKit [5.6.0]]()

<br>

#### 前言

****

时隔一年多, 骚栋又要开始助力开发工作效率的提升了,先前写过一个基于Masonry的自动布局方案, 这次写一个基于SnapKit的自动布局方案, 这种方案主要是应对于 **业务场景复杂多变,业务需求频繁变动** 导致的布局方案需要处理的分支情况过多. 如下所示.

``` Java
if (业务1条件满足) {
    if (业务2条件满足) {
        // 布局方案1
    }
    if (业务3条件满足) {
        if (业务4条件满足) {
            // 布局方案2
        } else {
            // 布局方案3
        }
    } else {
        // 布局方案4
    }
}
```
其实不用过于惊讶,这种场景是非常常见的,例如 A B C 三个视图从上往下布局, B隐藏时,A C要重新进行新的布局方案,如果这种还好一点,但是两个三个视图根据不同的业务场景隐藏时,这种分支情况就会变得如上复杂.

所以我在先前就想做一套浮动布局方案,核心思想就是 **一套布局方案,应对多种业务场景** ,于是就有了 [MasonryFloatLayout : 基于Masonry的浮动布局](https://coderdong.blog.csdn.net/article/details/115291655).

这次也是业务需要,所以这次就改造了SnapKit, 但是困难也是遇到也很多,这个放在后面讲,接下来先说一下怎么导入和快速上手使用.


<br>

#### 导入

***

* 手动导入

    手动导入需要只需要将工程中的 `SnapFloatLayout/SnapFloatLayout
/SnapFloatLayout` 所以文件拖到自己的工程中即可.


* cocoapods 导入

    暂未支持


<br>

#### 使用

***

整体上和 MasonryFloatLayout 相似, 这里举几个示例说明一下.

A B 两个视图添加到 superView 上.

``` Java
    lazy var firstView: UIView! = {
        var _firstView = UIView()
        _firstView.backgroundColor = UIColor.red
        _firstView.translatesAutoresizingMaskIntoConstraints = false
        return _firstView
    }()
    
    lazy var secondView: UIView! = {
        var _secondView = UIView()
        _secondView.backgroundColor = UIColor.orange
        _secondView.translatesAutoresizingMaskIntoConstraints = false
        return _secondView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.layoutSubViews()
    }
```

布局方式和 **SnapKit** 的类似(这是由于SnapFloatLayout基于SnapKit实现的), 代码如下所示. 

``` Java
    func layoutSubViews() {
        self.firstView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(self.view.snpFloat.left)
            make.width.equalTo(100)
            make.lastFloatConstraint?.offset(80)
            make.nextFloatConstraint?.offset(-30).priority(.low)
        }
        
        self.secondView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.lastFloatConstraint?.offset(8)
            make.nextFloatConstraint?.offset(-8)
        }
        [self.firstView, self.secondView].remakeFloatLayoutConstraints(orientation: .topToBottom, needLastConstraint: true)
    }
```

在布局代码的闭包中,我们可以通过 `lastFloatConstraint` 和 `nextFloatConstraint` 添加当前视图对前后视图的约束,其中我们除了需要可以设置偏移值( `offset` )外还可以设置约束优先级 ( `priority` ),至于为什么要有约束优先级我们后面来详细聊聊.

``` Java
make.lastFloatConstraint?.offset(80)
make.nextFloatConstraint?.offset(-30).priority(.low)
```

看起来是和 **SnapKit** 基本一致. 不过闭包中的参数除了 `make` 之外,还有 `lastView` 和 `nextView` 两个参数,我们可以这两个参数自行定义我们上下布局逻辑.当然了,这是为了扩展性而做了一些调整,使布局代码更加灵活.


其他约束条件也是和 **SnapKit** 一致, 同时它也支持同时使用 **SnapKit** 一起构建布局.因为他们最终实现都是生成 `NSLayoutConstraint`, 所以我们完全可以渐进的替代一部分布局逻辑代码.但是在 `remakeFloatLayoutConstraints` 我们只能使用 <Font color="red"> **snpFloat** </Font> 来获取其他约束条件如下所示.

``` Java
make.left.equalTo(self.view.snpFloat.left)
```

在各自添加布局代码之后,我们需要把浮动布局的视图添加到一个数组中,然后通过 `remakeFloatLayoutConstraints` 来添加布局. 通过 `needLastConstraint` 这个参数来确定参与浮动布局的最后一个元素的最后一个使用是否生效,效果可以达到 **自撑父视图** 效果

``` Java
[self.firstView, self.secondView].remakeFloatLayoutConstraints(orientation: .topToBottom, needLastConstraint: true)
```

如果各自视图添加完 `remakeFloatLayoutConstraints` 并没有调用 `remakeFloatLayoutConstraints`. 则很有可能因为循环引用问题会造成 <Font color="red"> **内存泄露** </Font>  这一点需要注意!!!! 

例如这样操作,约束布局不但不会生效还会造成循环引用问题 !!!!

``` Java
    func layoutSubViews() {
        self.firstView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(self.view.snpFloat.left)
            make.width.equalTo(100)
            make.lastFloatConstraint?.offset(80)
            make.nextFloatConstraint?.offset(-30).priority(.low)
        }
    }
```


<br> 


#### 一套布局方案应对多种业务场景

***

那么 SnapFloatLayout 是如何实现一套布局方案应对多种业务场景呢? 例如 **secondView** 视图因为业务场景隐藏,我们只需要先隐藏 **secondView** ,然后重新调用下布局代码即可.

这里使用TouchBegin来模拟业务数据所带来的UI变化

``` Java
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.secondView.isHidden = !self.secondView.isHidden
        self.layoutSubViews()
    }
```

大家不需要关心内部的实现,只需要关心如下三种情况就不会参与布局

* 没有添加到父视图

* 隐藏视图

* 没有通过 `remakeFloatLayoutConstraints` 添加布局


这时候点击效果就会如下所示.

![](http://dongjia-oss.oss-cn-beijing.aliyuncs.com/blog/snapfloatlayout_demo-2023-06-26-11-42-56.gif)


<br> 


#### priority约束优先级的妙用

***

其实很多人说你这种布局为什么不用UIStackView实现? 这也就是 SnapFloatLayout 与 UIStackView 的 本质区别,

UIStackView 虽然能实现间隔分布,但是间距距离是固定的,只能实现比较简单的,例如


``` Java
 A ← 20px → B ← 20px → C ← 20px → D
```

如果想要实现这种方案的话,BC之间的30px就比较麻烦.

``` Java
 A ← 20px → B ← 30px → C ← 20px → D
```

虽然可以把BC之间特殊的间距搞成B 或者 C 内部的间距,但是由于业务需要导致C隐藏B 与 D 之间的间距成为30px,这时候又该怎么办呢?只能通过条件判断C是否隐藏然后调整30px间距具体加在谁身上.

``` Java
 A ← 20px → B ← 30px → D
```

这只是一个视图C的隐藏,如果2个或者3个呢?(非臆想,业务复杂确实会有两三个动态的隐藏与显示,多了那才是臆想过度了)

这时候 SnapFloatLayout 的优先级参数就体现出作用来了. 就以C隐藏为示例,整体代码如上所示.

``` Java
func layoutSubViews() {
    A.remakeFloatLayoutConstraints { make, lastView, nextView in
        make.lastFloatConstraint?.offset(20)
        make.nextFloatConstraint?.offset(20)
    }
    
    B.remakeFloatLayoutConstraints { make, lastView, nextView in
        make.lastFloatConstraint?.offset(20)
        make.nextFloatConstraint?.offset(30).priority(.high)
    }
    
    C.remakeFloatLayoutConstraints { make, lastView, nextView in
        make.lastFloatConstraint?.offset(20)
        make.nextFloatConstraint?.offset(20)
    }
    
    D.remakeFloatLayoutConstraints { make, lastView, nextView in
        make.lastFloatConstraint?.offset(20)
        make.nextFloatConstraint?.offset(20)
    }

    [A, B, C, D].remakeFloatLayoutConstraints(orientation: .leftToRight, needLastConstraint: true)
}
```

设置B的nextFloatConstraint约束优先级较高,不管与哪个约束冲突时,B的nextFloatConstraint一定会先生效.

```
make.nextFloatConstraint?.offset(30).priority(.high)
```

不需要判断条件,优先级就可以完美解决这个问题.


<br> 


#### SnapFloatLayout 渐进式混合开发

***

由于 SnapFloatLayout 是基于 <Font color="green"> **SnapKit5.6.0** </Font> 做的功能扩展, 所以完全兼容两个混合使用.
同时, SnapFloatLayout 也支持普通的添加约束方式. 需要配合 <Font color="red"> **snpFloat** </Font> 使用.

示例代码如下所示.

``` Java
    func layoutSubViews() {
        self.firstView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(self.view.snpFloat.left)
            make.width.equalTo(100)
            make.lastFloatConstraint?.offset(80)
            make.nextFloatConstraint?.offset(-30).priority(.low)
        }
        
        self.secondView.remakeFloatLayoutConstraints { make, lastView, nextView in
            make.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.lastFloatConstraint?.offset(8)
            make.nextFloatConstraint?.offset(-8)
        }
        [self.firstView, self.secondView].remakeFloatLayoutConstraints(orientation: .topToBottom, needLastConstraint: true)
        
        self.thirdView.snpFloat.remakeConstraints { make in
            make.left.equalTo(self.firstView.snpFloat.right).offset(30)
            make.width.height.equalTo(100)
            make.top.equalTo(self.firstView)
        }
        
        self.fourthView.snp.remakeConstraints { make in
            make.left.equalTo(self.firstView.snp.right).offset(30)
            make.top.equalTo(self.thirdView.snp.bottom).offset(30)
            make.width.height.equalTo(60)
        }
    }
```

![](http://dongjia-oss.oss-cn-beijing.aliyuncs.com/blog/20230626141916-2023-06-26-14-19-16.png)


效果图如下所示,显示正常.

![](http://dongjia-oss.oss-cn-beijing.aliyuncs.com/blog/20230626141613-2023-06-26-14-16-14.png)



<br> 


#### SnapFloatLayout 与 MasonryFloatLayout

***

SnapFloatLayout 相对于 MasonryFloatLayout 实现起来比较麻烦,其主要原因就是 `internal` 关键字导致的 SnapKit 内部封闭性很强,外部改造非常麻烦. 所以我就相当于Copy了一份 SnapKit代码(基于5.6.0版本), 然后进行相对改造.所以并非像 MasonryFloatLayout 使用了Category分类一样嵌入到了 Masonry 中了. 也算是一个遗憾...

<br> 


#### End

***

虽然 SnapFloatLayout 的开发效果很高,但是还是需要注意其循环引用问题!!!!  这个是重点,需要注意!



