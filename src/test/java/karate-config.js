function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/',
  }
  if (env == 'dev') {
    config.userEmail = 'cloaiza@test.com';
    config.userPassword = 'karate1';
  } else if (env == 'qa') {
    config.userEmail = 'clf11@test.com';
    config.userPassword = 'karate11';
  }

  var accessToken = karate.callSingle('classpath:helpers/GetToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}