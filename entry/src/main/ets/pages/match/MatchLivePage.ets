import { CommonConstants } from '../../common/constants/CommonConstants';
import { RoutePath } from '../../route/RoutePath';
import { Router } from '../../route/Router';
import { CommonTopBar } from '../../view/CommonTopBar';

/**
 * The MainPage that is routed as the SplashScreenPage.
 */
@Entry
@Component
struct MatchLivePage {

  @State Number: String[] = ['0', '1', '2', '3', '4']

  aboutToAppear() {

  }

  build() {
    Column() {
      CommonTopBar({title: '赛事直播间', alpha: 1})

      Grid() {
        ForEach(this.Number, (day: string) => {
          ForEach(this.Number, (day: string) => {
            GridItem() {
              Text(day)
                .fontSize(16)
                .backgroundColor(0xF9CF93)
                .width('100%')
                .height(300)
                .textAlign(TextAlign.Center)
            }
            .onClick(() => {
              // Router.push(RoutePath.LivePlayerPage,)
            })
          }, day => day)
        }, day => day)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(10)
      .rowsGap(10)
      .onScrollIndex((first: number) => {
        console.info(first.toString())
      })
      .width('100%')
      .backgroundColor(0xFAEEE0)
      .height('100%')
    }
    .height(CommonConstants.MAIN_PAGE_ROW_WIDTH)
  }
}