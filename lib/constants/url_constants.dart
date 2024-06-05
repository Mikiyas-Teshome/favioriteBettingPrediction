const rootUrl = "http://192.168.8.143:8000/";
const localLoginUrl = "${rootUrl}api/login";
const localSignUpUrl = "${rootUrl}api/register";
const resendEmailUrl = "${rootUrl}api/resend-otp";
const verifyOtplUrl = "${rootUrl}api/verify-otp";
const signInWithGoogleUrl = "${rootUrl}api/signInWithGoogle";
const forgetPassUrl = "${rootUrl}api/forgetPass";
const verifyResetPassOtpUrl = "${rootUrl}api/verifyResetPassOtp";
const resetPassUrl = "${rootUrl}api/resetPass";

const fetchFreeCategoriesUrl =
    "https://api.totaltipsbet.com/v1/b2c/categories?page=0&max=50&type=free";

const fetchFreeTipsUrl =
    "https://api.totaltipsbet.com/v1/b2c/coupons?page=0&max=50&mode=NEWEST&purchases=%5Bobject%20Object%5D&category=";
