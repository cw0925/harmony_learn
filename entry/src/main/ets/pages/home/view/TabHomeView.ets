import util from '@ohos.util';
import { NewsDataSource } from '../../../datasource/CustomDataSource';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  private categoryList: any[] = [
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '体育资讯'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '官方赛事'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '协会组织'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '场馆预定'},
    {'key': util.generateRandomUUID(true),'icon': $r('app.media.home_temp'), 'name': '文旅中心'}
  ];
  private data: NewsDataSource = new NewsDataSource()

  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        this.BuildContent()
      }
      .tabBar('资讯')

    }
    .barMode(BarMode.Scrollable)
    .backgroundColor('#FAFAFA')
  }

  @Builder BuildContent() {
    Column() {
      this.BuildCategory()
      this.BuildActivity()
      this.BuildGrid()
    }
  }

  @Builder BuildCategory() {
    List() {
      ForEach(this.categoryList, (item: any) => {
        ListItem() {
          Column() {
            Image(item.icon)
              .width(40)
              .height(40)
              .margin(10)
            Text(item.name).fontSize(20)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
        }
      }, item => item.key)
    }
    .listDirection(Axis.Vertical)
    .lanes(5)
  }

  @Builder BuildActivity() {
    Column() {
      Row() {
        Image($r('app.media.home_temp'))
          .width('33%')
        Image($r('app.media.home_temp'))
          .width('33%')
        Image($r('app.media.home_temp'))
          .width('33%')
      }

      Row() {
        Image($r('app.media.home_temp'))
          .width('50%')
        Image($r('app.media.home_temp'))
          .width('50%')
      }
    }
  }

  @Builder BuildGrid() {
    Grid() {
      LazyForEach(this.data, item => {
        GridItem() {
          this.BuildGridItem()
        }
      })
    }
    .cachedCount(3)
    .columnsTemplate('1fr 1fr')
    .rowsGap(8)
    .columnsGap(8)
    .padding({left: 8, right: 8})
  }

  @Builder BuildGridItem() {
    Column() {
      Image($r('app.media.home_temp'))
        .height(224)

      Text('热门场馆热门场馆热门场馆')

      Row() {
        Row() {
          Image($r('app.media.avatar'))
            .width(18)
            .height(18)

          Text('作者')
        }
        Row() {
          Image($r('app.media.heart_grey'))
            .width(18)
            .height(18)

          Text('1')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .borderRadius(10)
    .backgroundColor(Color.White)
  }
}