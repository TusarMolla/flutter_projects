
import 'package:ober_app/events/seo_event.dart';

class OnChangeIndex  extends SeoEvent{
  int currentIndex;
  OnChangeIndex(this.currentIndex);
}