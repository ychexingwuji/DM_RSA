//
//  ViewController.m
//  DM_RSA
//
//  Created by brook on 16/10/17.
//  Copyright © 2016年 brook. All rights reserved.
//

// https://developer.apple.com/library/content/documentation/PassKit/Reference/PaymentTokenJSON/PaymentTokenJSON.html#//apple_ref/doc/uid/TP40014929

#import "ViewController.h"
#import "RSAEncryptor.h"
#import "RSAEncryptor2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testFileEncrypt];
    
//    [self testStringEncrypt];
    
    [self testDecryptAP];
    
    //[self testOpensslDecryptRSA];
}

- (void)testOpensslDecryptRSA
{
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSString *rsaPrivatekey = [RSAEncryptor getPrivatekeyFromP12Fiel:private_key_path password:@"123456"];
    
    NSLog(@"私钥 = %@", rsaPrivatekey);
    
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString *rsaPublickey = [RSAEncryptor getPublickeyFromCerFiel:public_key_path];
    
    NSLog(@"公钥 = %@", rsaPublickey);
    
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
    //    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"apple_pay" ofType:@"cer"];
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    
    //NSString *encryptStr = @"l6w4oBmvLF/f/6Gj7idhO5aIFlwZ5qZrqSLxR+mLqsjJqHLf2OUTObn+UOO/Iaupc+nc6Kuz1ZTQbBMG2w6/KC8F07lZTPnCOcHVxxBP03UQn6gNkNV8DLNNqJ9GoBDzbGy/dWgKBBPNEdgA59jKY+8H/XQzvNuZqiFDM4LTr+O3/FdqGy6PxfFHRwRNV15WoKtsfQ91xPf++MI4GoTZSdxpc63ewm/8l5Q81AqnZMH03PMRyu8POT92tl10tg8GRmQFCXMgBm7GM+6nz0tebOoLndspqHbe9xtAGmxzseuFCi4A2q8WaqzPgnQ917bvuUnxNHAkXoPTVIUCsXzxXA==";
    
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"123456"]);
    
    
    
    RSAEncryptor2 *helper = [[RSAEncryptor2 alloc] init];
    [helper extractEveryThingFromPKCS12File:private_key_path passphrase:@"123456"];
    NSData *encryptData = [helper encryptWithPublicKey:[@"hello world" dataUsingEncoding:NSUTF8StringEncoding]];
    encryptData = [encryptData base64EncodedDataWithOptions:0];
    NSString *encrytString222 = [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
    NSLog(@"222 加密后:%@", encrytString222);
    NSData *decryptData222 = [helper decryptWithPrivateKey:encryptData];
    decryptData222 = [decryptData222 base64EncodedDataWithOptions:0];
    NSString *decrytString222 = [[NSString alloc] initWithData:decryptData222 encoding:NSUTF8StringEncoding];
    NSLog(@"222 解密后:%@", decrytString222);
    
}

- (void)testDecryptAP
{
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private" ofType:@"p12"];
    NSString *rsaPrivatekey = [RSAEncryptor getPrivatekeyFromP12Fiel:private_key_path password:@"123456"];
    
    NSLog(@"私钥 = %@", rsaPrivatekey);
    
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"apple_pay" ofType:@"cer"];
    NSString *rsaPublickey = [RSAEncryptor getPublickeyFromCerFiel:public_key_path];
    
    NSLog(@"公钥 = %@", rsaPublickey);
    
   // NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
//    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"apple_pay" ofType:@"cer"];
    //SString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    
    NSString *encryptStr = @"l6w4oBmvLF/f/6Gj7idhO5aIFlwZ5qZrqSLxR+mLqsjJqHLf2OUTObn+UOO/Iaupc+nc6Kuz1ZTQbBMG2w6/KC8F07lZTPnCOcHVxxBP03UQn6gNkNV8DLNNqJ9GoBDzbGy/dWgKBBPNEdgA59jKY+8H/XQzvNuZqiFDM4LTr+O3/FdqGy6PxfFHRwRNV15WoKtsfQ91xPf++MI4GoTZSdxpc63ewm/8l5Q81AqnZMH03PMRyu8POT92tl10tg8GRmQFCXMgBm7GM+6nz0tebOoLndspqHbe9xtAGmxzseuFCi4A2q8WaqzPgnQ917bvuUnxNHAkXoPTVIUCsXzxXA==";
    
  //NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptWrappedKey:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"123456"]);
}

- (void)testFileEncrypt
{
    //原始数据
    NSString *originalString = @"这是一段将要使用'.der'文件加密的字符串!";
    
    //使用.der和.p12中的公钥私钥加密解密
    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"123456"]);
}

- (void)testStringEncrypt
{
    // 在线生成地址：http://web.chacuo.net/netrsakeypair
    
    //原始数据
    NSString *originalString = @"这是一段将要使用'秘钥字符串'进行加密的字符串!";
    
    //使用字符串格式的公钥私钥加密解密
    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB"];
    
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr privateKey:@"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
