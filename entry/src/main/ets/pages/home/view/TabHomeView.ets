import MatchView from '../../match/view/MatchView';
import MatchUnionView from '../../match/view/MatchUnionView';
import MatchClubView from '../../match/view/MatchClubView';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabHomeView {

  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        MatchView()
      }
      .tabBar('赛事')

      TabContent() {
        MatchUnionView()
      }
      .tabBar('协会')

      TabContent() {
        MatchClubView()
      }
      .tabBar('俱乐部')

    }
    .barMode(BarMode.Scrollable)
    .backgroundColor('#FAFAFA')
  }
}