/**
 * 自定义App顶部Topbar
 */
import router from '@ohos.router'
import window from '@ohos.window';
import { LogUtil } from '../utils/LogUtil';

@Component
export struct CommonTopBar {
  @Prop title: string
  @Prop alpha: number
  @State statusBarHeight: number = 0
  private titleAlignment: TextAlign = TextAlign.Center
  private backButton: boolean = true
  private onBackClick?: () => void

  aboutToAppear() {
    this.setSystemStatusBar()
  }

  setSystemStatusBar() {
    let context = getContext(this)
    window.getLastWindow(context, (error, data) => {
      //1、设置系统状态栏
      let avoidArea = data.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      //这里为什么要自己设置一个高度？因为系统返回的高度太高了，并不能正确的返回系统状态栏的高度，自己二次设置一个接近的值
      avoidArea.topRect.height = 90
      this.statusBarHeight = avoidArea.topRect.height
      LogUtil.debug("顶部状态栏的高度", `${this.statusBarHeight}`)
      let bottomHeight = avoidArea.bottomRect.height
      LogUtil.debug("底部系统导航栏的高度", `${bottomHeight}`)
      //2、设置系统状态栏颜色---该API废弃了，统一返回801，目前没找到好的方法设置状态栏文字的颜色，放弃了。。。。。。
      const systemBarProperties: window.SystemBarProperties = {
        //顶部状态栏颜色
        statusBarColor: "#ffffff",
        statusBarContentColor: "#ffffff",
        isStatusBarLightIcon: true
      }
      data.setWindowSystemBarProperties(systemBarProperties, (err, result) => {
        LogUtil.debug("设置状态栏结果码", `${err.code}`)
        if (err.code == 0) {
          LogUtil.debug("状态栏设置成功")
        } else {
          LogUtil.debug("状态栏设置失败", `${err.message}`)
        }
      })
    })
  }

  build() {
    Column() {
      Blank()
        .backgroundColor(Color.White)
        .opacity(this.alpha)
      Stack({ alignContent: Alignment.Start }) {
        Stack()
          .height(50)
          .width("100%")
          .opacity(this.alpha)
          .backgroundColor(Color.White)
        Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) {
          Text(this.title)
            .flexGrow(1)
            .textAlign(this.titleAlignment)
            .fontColor(Color.Black)
            .fontSize(16)
            .align(Alignment.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .height(50)
        .margin({ left: 50, right: 50 })
        .alignSelf(ItemAlign.Center)

        if (this.backButton) {
          Stack() {
            Image($r('app.media.nav_left'))
              .height(16)
              .width(16)
              .align(Alignment.Center)
              .onClick(() => {
                this.onBackClick?.()
                router.back();
              })
          }
          .height(50)
          .width(50)
        }
      }
      .height(50)
      .width("100%")
    }.height(this.statusBarHeight)

  }
}