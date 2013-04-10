Rails.application.config.middleware.use OmniAuth::Builder do
  # development
  #provider :google_oauth2, '913065139654.apps.googleusercontent.com', '_LpkzksnVfPdOnCgFHtsXwac'
  # production
  provider :google_oauth2, '913065139654-be63smp3372ul7otp5dd2grc82ms5ti3.apps.googleusercontent.com',
   'JrYbqweo6bi3asNmJEDp_-q3'
end
