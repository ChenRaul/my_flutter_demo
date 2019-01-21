import 'dart:convert' show json;

class NewsDetailResponse {

  bool success;
  Data data;

  NewsDetailResponse.fromParams({this.success, this.data});

  factory NewsDetailResponse(jsonStr) => jsonStr == null ? null : jsonStr is String ? new NewsDetailResponse.fromJson(json.decode(jsonStr)) : new NewsDetailResponse.fromJson(jsonStr);

  NewsDetailResponse.fromJson(jsonRes) {
    success = jsonRes['success'];
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"success": $success,"data": $data}';
  }
}

class Data {

  int replyCount;
  int visitCount;
  bool good;
  bool isCollect;
  bool top;
  String authorId;
  String content;
  String createAt;
  String id;
  String lastReplyAt;
  String tab;
  String title;
  List<Reply> replies;
  Author author;

  Data.fromParams({this.replyCount, this.visitCount, this.good, this.isCollect, this.top, this.authorId, this.content, this.createAt, this.id, this.lastReplyAt, this.tab, this.title, this.replies, this.author});

  Data.fromJson(jsonRes) {
    replyCount = jsonRes['reply_count'];
    visitCount = jsonRes['visit_count'];
    good = jsonRes['good'];
    isCollect = jsonRes['is_collect'];
    top = jsonRes['top'];
    authorId = jsonRes['author_id'];
    content = jsonRes['content'];
    createAt = jsonRes['create_at'];
    id = jsonRes['id'];
    lastReplyAt = jsonRes['last_reply_at'];
    tab = jsonRes['tab'];
    title = jsonRes['title'];
    replies = jsonRes['replies'] == null ? null : [];

    for (var repliesItem in replies == null ? [] : jsonRes['replies']){
      replies.add(repliesItem == null ? null : new Reply.fromJson(repliesItem));
    }

    author = jsonRes['author'] == null ? null : new Author.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"reply_count": $replyCount,"visit_count": $visitCount,"good": $good,"is_collect": $isCollect,"top": $top,"author_id": ${authorId != null?'${json.encode(authorId)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"create_at": ${createAt != null?'${json.encode(createAt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"last_reply_at": ${lastReplyAt != null?'${json.encode(lastReplyAt)}':'null'},"tab": ${tab != null?'${json.encode(tab)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"replies": $replies,"author": $author}';
  }
}

class Author {

  String avatarUrl;
  String loginName;

  Author.fromParams({this.avatarUrl, this.loginName});

  Author.fromJson(jsonRes) {
    avatarUrl = jsonRes['avatar_url'];
    loginName = jsonRes['loginname'];
  }

  @override
  String toString() {
    return '{"avatar_url": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"loginname": ${loginName != null?'${json.encode(loginName)}':'null'}}';
  }
}

class Reply {

  Object replyId;
  bool isUped;
  String content;
  String createAt;
  String id;
  List<String> ups;
  ReplyAuthor author;

  Reply.fromParams({this.replyId, this.isUped, this.content, this.createAt, this.id, this.ups, this.author});

  Reply.fromJson(jsonRes) {
    replyId = jsonRes['reply_id'];
    isUped = jsonRes['is_uped'];
    content = jsonRes['content'];
    createAt = jsonRes['create_at'];
    id = jsonRes['id'];
    ups = jsonRes['ups'] == null ? null : [];

    for (var upsItem in ups == null ? [] : jsonRes['ups']){
      ups.add(upsItem);
    }

    author = jsonRes['author'] == null ? null : new ReplyAuthor.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"reply_id": $replyId,"is_uped": $isUped,"content": ${content != null?'${json.encode(content)}':'null'},"create_at": ${createAt != null?'${json.encode(createAt)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"ups": $ups,"author": $author}';
  }
}

class ReplyAuthor {

  String avatarUrl;
  String loginName;

  ReplyAuthor.fromParams({this.avatarUrl, this.loginName});

  ReplyAuthor.fromJson(jsonRes) {
    avatarUrl = jsonRes['avatar_url'];
    loginName = jsonRes['loginname'];
  }

  @override
  String toString() {
    return '{"avatar_url": ${avatarUrl != null?'${json.encode(avatarUrl)}':'null'},"loginname": ${loginName != null?'${json.encode(loginName)}':'null'}}';
  }
}

