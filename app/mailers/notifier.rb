class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def comment_updated(comment, post_author)
    @comment = comment
    @user = comment.author
    @post = comment.post
    subject = "[blogee] #{@post.title} - Commment by #{@post.author}"
    mail(:to => @post.user.email, :subject => subject)
  end
end
