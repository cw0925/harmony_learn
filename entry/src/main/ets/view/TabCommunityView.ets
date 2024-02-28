import { CommonConstants } from '../common/constants/CommonConstants';

/**
 * Copyright component for splash screen page.
 */
@Component
export default struct TabCommunityView {
  build() {
    Tabs({ barPosition: BarPosition.Start }) {

      TabContent() {
        Text('HomeNewsView的内容').fontSize(30)
      }
      .tabBar('资讯')

    }.barMode(BarMode.Scrollable)
  }
}