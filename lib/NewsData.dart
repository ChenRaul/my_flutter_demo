import 'dart:convert' show json;

//列表数据的json序列化，使用Formatter_win工具生成，工程里面有
class NewsData {

  bool success;
  List<NewsList> data;

  NewsData.fromParams({this.success, this.data});

  factory NewsData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NewsData.fromJson(json.decode(jsonStr)) : new NewsData.fromJson(jsonStr);

  NewsData.fromJson(jsonRes) {
    success = jsonRes['success'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new NewsList.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"success": $success,"data": $data}';
  }
}

class NewsList {

  int reply_count;
  int visit_count;
  bool good;
  bool top;
  String author_id;
  String content;
  String create_at;
  String id;
  String last_reply_at;
  String tab;
  String title;
  AuthorInfo author;

  NewsList.fromParams({this.reply_count, this.visit_count, this.good, this.top, this.author_id, this.content, this.create_at, this.id, this.last_reply_at, this.tab, this.title, this.author});

  NewsList.fromJson(jsonRes) {
    reply_count = jsonRes['reply_count'];
    visit_count = jsonRes['visit_count'];
    good = jsonRes['good'];
    top = jsonRes['top'];
    author_id = jsonRes['author_id'];
    content = jsonRes['content'];
    create_at = jsonRes['create_at'];
    id = jsonRes['id'];
    last_reply_at = jsonRes['last_reply_at'];
    tab = jsonRes['tab'];
    title = jsonRes['title'];
    author = jsonRes['author'] == null ? null : new AuthorInfo.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"reply_count": $reply_count,"visit_count": $visit_count,"good": $good,"top": $top,"author_id": ${author_id != null?'${json.encode(author_id)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"create_at": ${create_at != null?'${json.encode(create_at)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"last_reply_at": ${last_reply_at != null?'${json.encode(last_reply_at)}':'null'},"tab": ${tab != null?'${json.encode(tab)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"author": $author}';
  }
}

class AuthorInfo {

  String avatarUrl;
  String loginname;

  AuthorInfo.fromParams({this.avatarUrl, this.loginname});

  AuthorInfo.fromJson(jsonRes) {
    avatarUrl = jsonRes['avatar_url'];
    loginname = jsonRes['loginname'];
  }

  @override
  String toString() {
    return '{"avatar_url": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"loginname": ${loginname != null?'${json.encode(loginname)}':'null'}}';
  }
}

