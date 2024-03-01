import TabCommunityView from '../view/TabCommunityView';
import TabMallView from '../view/TabMallView';
import TabMyView from '../view/TabMyView';
import TabHomeView from './home/view/TabHomeView';

@Entry
@Component
struct TabPage {

  private tabsController : TabsController = new TabsController()
  @State currentIndex:number = 0;

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {

      TabContent() {
        TabHomeView()
      }
      .tabBar(this.TabBuilder('赛事', 0, $r('app.media.tab_home_select'), $r('app.media.tab_home')))

      TabContent() {
        TabCommunityView()
      }
      .tabBar(this.TabBuilder('发现', 1, $r('app.media.tab_community_select'), $r('app.media.tab_community')))

      TabContent() {
        TabMallView()
      }
      .tabBar(this.TabBuilder('商城', 2, $r('app.media.tab_mall_select'), $r('app.media.tab_mall')))

      TabContent() {
        TabMyView()
      }
      .tabBar(this.TabBuilder('我的', 3, $r('app.media.tab_my_select'), $r('app.media.tab_my')))

    }
    .barMode(BarMode.Fixed)
    .scrollable(false)
  }
  // 自定义TabBar
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#FF5B85F0' : '#989898')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(
      () => {
        this.currentIndex = targetIndex;
        this.tabsController.changeIndex(this.currentIndex);
      }
    )
  }

}

