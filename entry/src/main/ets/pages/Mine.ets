import { router } from '@kit.ArkUI'

@Entry
@Component
struct Mine {
  @State currentTab: number = 1

  build() {
    Column() {
      // 第一个模块 - 用户信息模块
      Column() {
        // 顶部用户信息行 - 使用与Index页面相同的布局方式
        Row() {
          // 头像 - 占高度七分之一，放在左边
          Image($r('app.media.avatar'))
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ left: 16 })

          // 用户信息和编辑资料区域 - 与Index页面相同的距离
          Column() {
            // 用户名和等级行
            Row() {
              Text('花粉用户')
                .fontSize(18)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Medium)

              // 等级标签 - 浅橙色圆框
              Text('lv3')
                .fontSize(12)
                .fontColor('#FF8C00')
                .fontWeight(FontWeight.Bold)
                .backgroundColor('#FFF0E0')
                .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                .borderRadius(8)
                .margin({ left: 8 })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })

            // 编辑资料按钮 - 浅蓝色圆框
            Text('编辑资料')
              .fontSize(14)
              .fontColor('#1698CE')
              .fontWeight(FontWeight.Bold)
              .backgroundColor('#E6F7FF')
              .padding({ left: 16, right: 16, top: 6, bottom: 6 })
              .borderRadius(16)
              .margin({ top: 6 })
          }
          .margin({ left: 8 })

          //.layoutWeight(1) // 占据剩余空间，将设置图标推到右边

          // 设置图标 - 头像的四分之一大小，放在最右边
          Image($r('app.media.settings'))
            .width(20)
            .height(20)
            .margin({ left: 105 })
        }
        .width('100%')
        .height(100) // 七分之一高度
        .alignItems(VerticalAlign.Center)

        // 数据统计行
        Row() {
          // 帖子
          Column() {
            Text('32')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Text('帖子')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)

          // 关注
          Column() {
            Text('256')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Text('关注')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)

          // 粉丝
          Column() {
            Text('128')
              .fontSize(18)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
            Text('粉丝')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(50) // 头像的二分之一高度
        .margin({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ top: 12, left: 12, right: 12 })
      .padding({ top: 16, bottom: 16 })

      // 第二个模块 - 功能菜单模块
      Column() {
        // 我的收藏
        Row() {
          Image($r('app.media.favorite'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
          Text('我的收藏')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 12 })
            .layoutWeight(1)
          Image($r('app.media.arrow_right'))
            .width(20)
            .height(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80) // 增加行高
        .alignItems(VerticalAlign.Center)

        // 分隔线
        Divider()
          .color('#F0F0F0')
          .margin({ left: 16, right: 16 })

        // 浏览历史
        Row() {
          Image($r('app.media.history'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
          Text('浏览历史')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 12 })
            .layoutWeight(1)
          Image($r('app.media.arrow_right'))
            .width(20)
            .height(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80) // 增加行高
        .alignItems(VerticalAlign.Center)

        // 分隔线
        Divider()
          .color('#F0F0F0')
          .margin({ left: 16, right: 16 })

        // 消息中心
        Row() {
          Image($r('app.media.message'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
          Text('消息中心')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 12 })
            .layoutWeight(1)
          Image($r('app.media.arrow_right'))
            .width(20)
            .height(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80) // 增加行高
        .alignItems(VerticalAlign.Center)

        // 分隔线
        Divider()
          .color('#F0F0F0')
          .margin({ left: 16, right: 16 })

        // 意见反馈
        Row() {
          Image($r('app.media.feedback'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
          Text('意见反馈')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 12 })
            .layoutWeight(1)
          Image($r('app.media.arrow_right'))
            .width(20)
            .height(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80) // 增加行高
        .alignItems(VerticalAlign.Center)

        // 分隔线
        Divider()
          .color('#F0F0F0')
          .margin({ left: 16, right: 16 })

        // 关于我们
        Row() {
          Image($r('app.media.about'))
            .width(24)
            .height(24)
            .margin({ left: 16 })
          Text('关于我们')
            .fontSize(16)
            .fontColor(Color.Black)
            .margin({ left: 12 })
            .layoutWeight(1)
          Image($r('app.media.arrow_right'))
            .width(20)
            .height(20)
            .margin({ right: 16 })
        }
        .width('100%')
        .height(80) // 增加行高
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(12)
      .margin({ top: 12, left: 12, right: 12 })
      .layoutWeight(1) // 占据剩余空间

      // 底部导航栏 - 与Index页面完全一致
      Row() {
        // 首页
        Column() {
          Image($r('app.media.home_normal')) // 使用未选中状态
            .width(24)
            .height(24)
          Text('首页')
            .fontSize(12)
            .fontColor('#666666') // 灰色，未选中状态
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          router.replaceUrl({
            url: 'pages/Index'
          })
        })
        .alignItems(HorizontalAlign.Center)

        // 我的
        Column() {
          Image($r('app.media.mine_selected')) // 使用选中状态
            .width(24)
            .height(24)
          Text('我的')
            .fontSize(12)
            .fontColor('#3E8AD9') // 蓝色，选中状态
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          // 已经在当前页面，不需要操作
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
  }
}