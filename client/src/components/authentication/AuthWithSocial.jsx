// material
import { Stack, Button, Divider, Typography } from '@material-ui/core';
import { GoogleLogin, GoogleOAuthProvider } from '@react-oauth/google';
// hooks
import { useSnackbar } from 'notistack';
import useAuth from '../../hooks/useAuth';
import useLocales from '../../hooks/useLocales';
// icons
import { FacebookIcon, GoogleIcon, TwitterIcon } from '../../assets';

// ----------------------------------------------------------------------

export default function AuthWithSocial({ isLogin }) {
  const { t } = useLocales();
  const { googleOAuth, loginWithFaceBook, loginWithTwitter } = useAuth();
  const { enqueueSnackbar } = useSnackbar();

  const handleGoogleLoginSuccess = async (tokenResponse) => {
    console.log('Google login succes:', tokenResponse);
    // const tokenId = tokenResponse;
    await googleOAuth(tokenResponse);
  };

  const handleGoogleLoginFailure = (err) => {
    console.log('Google login failed', err);
    const mess = t('auth.login-failed-with', { provider: 'Google', message: err.message });
    enqueueSnackbar(mess, { variant: 'error' });
  };

  const handleLoginFaceBook = async () => {
    try {
      await loginWithFaceBook();
    } catch (error) {
      console.error(error);
    }
  };

  const handleLoginTwitter = async () => {
    try {
      await loginWithTwitter();
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <GoogleOAuthProvider clientId="62945391421-7d6riokgvcokh2s80n86cgke51elvu9a.apps.googleusercontent.com">
      <Stack direction="row" spacing={2}>
        <GoogleLogin
          onSuccess={handleGoogleLoginSuccess}
          onError={handleGoogleLoginFailure}
          render={(renderProps) => (
            <Button
              fullWidth
              size="large"
              color="inherit"
              variant="outlined"
              onClick={renderProps.onClick}
              disabled={renderProps.disabled}
            >
              <GoogleIcon disabled={renderProps.disabled} />
            </Button>
          )}
        />

        <Button fullWidth size="large" color="inherit" variant="outlined" onClick={handleLoginFaceBook}>
          <FacebookIcon disabled />
        </Button>

        <Button fullWidth size="large" color="inherit" variant="outlined" onClick={handleLoginTwitter}>
          <TwitterIcon disabled />
        </Button>
      </Stack>

      {isLogin && (
        <Divider sx={{ my: 3 }}>
          <Typography variant="body2" sx={{ color: 'text.secondary' }}>
            {t('auth.or').toUpperCase()}
          </Typography>
        </Divider>
      )}
    </GoogleOAuthProvider>
  );
}
