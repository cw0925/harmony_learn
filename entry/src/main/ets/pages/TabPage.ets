import TabHomeView from '../view/TabHomeView';
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
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.tab_home_select'), $r('app.media.tab_home')))

      TabContent() {
        Column(){
          Text('社区内容')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#007DFF')
      }
      .tabBar(this.TabBuilder('社区', 1, $r('app.media.tab_community_select'), $r('app.media.tab_community')))

      TabContent() {
        Column(){
          Text('赛事内容')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#007DFF')
      }
      .tabBar(this.TabBuilder('赛事', 2, $r('app.media.tab_match_select'), $r('app.media.tab_match')))

      TabContent() {
        Column(){
          Text('商城内容')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#007DFF')
      }
      .tabBar(this.TabBuilder('商城', 3, $r('app.media.tab_mall_select'), $r('app.media.tab_mall')))

      TabContent() {
        Column(){
          Text('我的内容')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#007DFF')
      }
      .tabBar(this.TabBuilder('我的', 4, $r('app.media.tab_my_select'), $r('app.media.tab_my')))

    }
    .barMode(BarMode.Fixed)
  }

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

