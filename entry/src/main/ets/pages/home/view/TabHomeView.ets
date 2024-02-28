import { CommonConstants } from '../../../common/constants/CommonConstants';
import { NewsDataSource } from '../../../datasource/CustomDataSource';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  private data: NewsDataSource = new NewsDataSource()

  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        this.BuildContent()
      }
      .tabBar('资讯')

    }.barMode(BarMode.Scrollable)
  }

  @Builder BuildContent() {
    Column() {
      Grid() {
        LazyForEach(this.data, item => {
          GridItem() {
            this.BuildGridItem()
          }
        })
      }
      .cachedCount(3)
      .margin({left: 8, right: 8})
      .columnsTemplate('1fr 1fr')
      .rowsGap(4)
      .columnsGap(8)
    }
  }

  @Builder BuildGridItem() {
    Column() {
      Image($r('app.media.home_temp'))
        .height(224)
      Text('热门场馆热门场馆热门场馆')
      Row() {
        Image($r('app.media.avatar'))
          .width(18)
          .height(18)
      }
    }
    .width('100%')
    .margin({left: 8, top: 8, right: 4, bottom: 8})
    .backgroundColor(Color.Green)
  }
}