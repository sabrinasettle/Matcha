class UserMailer < ApplicationMailer
    # default :from => "not.tea.its.matcha@gmail.com"
    # Matchaluv42!

    #app password vaao kizc lror zawi #may not need whitespaces

    # https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial
    # https://stackoverflow.com/questions/472450/how-do-i-create-email-with-css-and-images-from-rails
    def registration_confirmation(user)
        @user = user
        mail(to: "#{@user.first_name} <#{@user.email}>", subject: "Welcome to Matcha")
        # puts user.email
    end

    def password_reset(user)
        @user = user
        mail(to: "#{@user.first_name} <#{@user.email}>", subject: "Password Reset for Matcha")
    end

    def password_reset_finalized(user)
        @user = user
        mail(to: "#{@user.first_name} <#{@user.email}>", subject: "Password Changed for Matcha")
    end
end
