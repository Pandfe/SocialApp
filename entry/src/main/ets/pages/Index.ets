import { router } from '@kit.ArkUI'

// 帖子数据接口
interface PostData {
  id: number
  username: string
  time: string
  title: string
  content: string
  likes: number
  comments: number
  shares: number
}

@Entry
@Component
struct Index {
  @State currentTab: number = 0
  @State searchText: string = ''
  @State welcomeMessage: string = ''
  @State showWelcome: boolean = false

  // 帖子数据
  private postData: PostData[] = [
    {
      id: 1,
      username: "花粉001",
      time: "2023-09-01",
      title: "华为Mate 60系列体验",
      content: "今天入手了华为Mate 60 Pro，体验非常流畅，鸿蒙系统的交互设计很人性化",
      likes: 128,
      comments: 32,
      shares: 15
    },
    {
      id: 2,
      username: "数码爱好者",
      time: "2023-08-31",
      title: "鸿蒙使用感受",
      content: "升级了鸿蒙，新功能真的很实用",
      likes: 89,
      comments: 24,
      shares: 8
    },
    {
      id: 3,
      username: "科技达人",
      time: "2023-08-30",
      title: "华为Watch开箱",
      content: "新买的华为手表，续航真的很给力，健康监测功能也很全面",
      likes: 156,
      comments: 42,
      shares: 21
    }
  ]

  // 页面显示时获取路由参数
  onPageShow(): void {
    const params = router.getParams() as Record<string, string>
    if (params && typeof params.account === 'string' && params.account.length > 0) {
      this.welcomeMessage = '登录成功！欢迎您 ' + params.account
      this.showWelcome = true

      // 3秒后自动隐藏欢迎消息
      setTimeout(() => {
        this.showWelcome = false
      }, 2000)
    }
  }

  // 构建单个帖子
  @Builder PostItem(post: PostData) {
    Column() {
      // 用户信息行
      Row() {
        // 头像 - 使用固定尺寸而不是百分比
        Image($r('app.media.avatar'))
          .width(40)
          .height(40)
          .borderRadius(20)
          .margin({ left: 12 })

        // 用户名和时间
        Column() {
          Text(post.username)
            .fontSize(16)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
          Text(post.time)
            .fontSize(12)
            .fontColor('#999999')
        }
        .layoutWeight(1)
        .margin({ left: 8 })
        .alignItems(HorizontalAlign.Start)

        // 关注按钮 - 调整尺寸
        Button('关注', { type: ButtonType.Circle })
          .width(50)
          .height(28)
          .backgroundColor('#3E8AD9')
          .fontColor(Color.White)
          .fontSize(12)
          .margin({ right: 12 })
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)

      // 标题
      Text(post.title)
        .fontSize(18)
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .margin({
          left: 12,
          top: 8,
          right: 12
        })
        .align(Alignment.Start)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 正文
      Text(post.content)
        .fontSize(14)
        .fontColor('#666666')
        .margin({
          left: 12,
          top: 6,
          right: 12
        })
        .align(Alignment.Start)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 帖子图片 - 使用固定高度而不是百分比
      Image($r('app.media.post'))
        .width('75%')
        .height(180)
        .margin({
          top: 12,
          bottom: 12
        })
        .borderRadius(8)
        .objectFit(ImageFit.Cover)

      // 互动区域 - 固定高度
      Row() {
        // 左边：点赞和评论
        Row() {
          Image($r('app.media.like'))
            .width(18)
            .height(18)
          Text(post.likes.toString())
            .fontSize(12)
            .fontColor('#666666')
            .margin({ left: 4 })

          Image($r('app.media.comment'))
            .width(18)
            .height(18)
            .margin({ left: 20 })
          Text(post.comments.toString())
            .fontSize(12)
            .fontColor('#666666')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)

        // 右边：转发
        Row() {
          Image($r('app.media.share'))
            .width(18)
            .height(18)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
        .margin({ right: 12 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(40)
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: 8 })
    }
    .width('100%')
    .backgroundColor(Color.White)
    .margin({ bottom: 8 })
    .borderRadius(20)
    .padding({ top: 8, bottom: 8 })
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // 主内容区域
      Column() {
        // 搜索框
        Row() {
          // 搜索图标 - 使用固定尺寸
          Image($r('app.media.search'))
            .width(24)
            .height(24)
            .margin({ left: 16 })

          // 搜索输入框
          TextInput({
            placeholder: '搜索感兴趣的内容',
            text: this.searchText
          })
            .placeholderColor('#CCCCCC')
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .height(40)
            .margin({ left: 12, right: 12 })
            .borderRadius(20)
            .padding({ left: 8, right: 8 })
            .onChange((value: string) => {
              this.searchText = value
            })

          // 扫描图标 - 使用固定尺寸
          Image($r('app.media.scan'))
            .width(24)
            .height(24)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .alignItems(VerticalAlign.Center)
        .borderRadius(12)
        .margin({ top: 8 })

        // 帖子列表
        Scroll() {
          Column() {
            ForEach(this.postData, (post: PostData) => {
              this.PostItem(post)
            })
          }
          .width('100%')
          .padding(12)
        }
        .layoutWeight(1)
        .margin({ top: 8 })

        // 底部导航栏
        Row() {
          // 首页
          Column() {
            Image($r('app.media.home_selected')) // 使用未选中状态
              .width(24)
              .height(24)
            Text('首页')
              .fontSize(12)
              .fontColor('#3E8AD9') // 蓝色，选中状态
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .onClick(() => {
            // 已经在当前页面，不需要操作
           /* router.replaceUrl({
              url: 'pages/Index'
            })*/
          })
          .alignItems(HorizontalAlign.Center)

          // 我的
          Column() {
            Image($r('app.media.mine_normal')) // 使用选中状态
              .width(24)
              .height(24)
            Text('我的')
              .fontSize(12)
              .fontColor('#666666') // 灰色，未选中状态
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/Mine'
            })
          })
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(60)
        .backgroundColor(Color.White)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor("#F1F3F5")

      // 登录成功欢迎消息 - 在导航栏上方居中显示
      if (this.showWelcome) {
        Column() {
          Text(this.welcomeMessage)
            .fontSize(16)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        }
        .backgroundColor(Color.White)
        .borderRadius(20)
        .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .alignItems(HorizontalAlign.Center)
        .position({ x: 0, y: 0 })
        .margin({ top: '85%', left: '10%', right: '10%' })
      }
    }
    .width('100%')
    .height('100%')
  }
}