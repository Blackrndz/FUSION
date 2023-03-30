/* ****************************************************************************
 * $Revision:  $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-05-16 $:
 * $HeadURL: $:
 * $Id: Manage Payment Process Profiles - Sequence Settings.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
 
SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME          				RES_NAME 
, IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  										RES_CODE 
, pm.periodic_sequence_name    													RES_SEQUENCES_IDENTIFIER
, Account.KEY 																	RES_PAYMENT_SYSTEM_ACCOUNT
,Detail.RESET_VALUE_1															RES_RESET_SEQUENCE_VALUE
,Detail.LAST_USED_NUMBER_1														RES_LAST_USED_NUMBER
, Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, Detail.CREATED_BY  RSC_CREATED_BY
, Detail.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL    IbySysPmtProfilesVl,
     (
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_1    periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B  
      where periodic_sequence_name_1 is not null
      
      union
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_2   periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B   
      where periodic_sequence_name_2 is not null
      
      union
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_3   periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B  
      where periodic_sequence_name_3 is not null
      ) PM
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
  ,
  (
  select  SYSTEM_PROFILE_CODE
  ,PAYMENT_PROFILE_NAME
  ,BEP_ACCOUNT_ID
       ,RESET_VALUE_1    
       ,LAST_USED_NUMBER_1
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_1 is not null
   union   
    
   select  SYSTEM_PROFILE_CODE
   ,PAYMENT_PROFILE_NAME
     ,BEP_ACCOUNT_ID
       ,RESET_VALUE_2    
       ,LAST_USED_NUMBER_2
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_2 is not null
      
   union   
        select  SYSTEM_PROFILE_CODE
        ,PAYMENT_PROFILE_NAME
          ,BEP_ACCOUNT_ID
       ,RESET_VALUE_3    
       ,LAST_USED_NUMBER_3
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_3 is not null
 
  )Detail
  ,IBY_BEPKEYS Account
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE         = PM.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
AND   PM.SYSTEM_PROFILE_CODE =  Detail.SYSTEM_PROFILE_CODE
AND  Account.BEPID = IbySysPmtProfilesVl.BEPID
AND  Account.BEP_ACCOUNT_ID = Detail.BEP_ACCOUNT_ID



UNION


SELECT DISTINCT IbySysPmtProfilesVl.SYSTEM_PROFILE_NAME          							RES_NAME 
, IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE  													RES_CODE 
, pm.periodic_sequence_name    																RES_SEQUENCES_IDENTIFIER
,Account.KEY  																				RES_PAYMENT_SYSTEM_ACCOUNT
,Detail.RESET_VALUE_1																		RES_RESET_SEQUENCE_VALUE
,Detail.LAST_USED_NUMBER_1																	RES_LAST_USED_NUMBER
, Detail.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, Detail.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, Detail.CREATED_BY  RSC_CREATED_BY
, Detail.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, TO_CHAR(PaymentDocumentE0.ACCOUNT_OWNER_ORG_ID) RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM IBY_SYS_PMT_PROFILES_VL    IbySysPmtProfilesVl,
     (
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_1    periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B  
      where periodic_sequence_name_1 is not null
      
      union
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_2   periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B   
      where periodic_sequence_name_2 is not null
      
      union
      select  SYSTEM_PROFILE_CODE
       ,periodic_sequence_name_3   periodic_sequence_name
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_SYS_PMT_PROFILES_B  
      where periodic_sequence_name_3 is not null
      ) PM
,(SELECT CePaymentDocuments.PAYMENT_DOCUMENT_ID
	,CeBankAccounts.ACCOUNT_OWNER_ORG_ID
	FROM CE_PAYMENT_DOCUMENTS CePaymentDocuments
	,CE_INTERNAL_BANK_ACCTS_V CeBankAccounts
	WHERE CePaymentDocuments.INTERNAL_BANK_ACCOUNT_ID = CeBankAccounts.BANK_ACCOUNT_ID
	) PaymentDocumentE0
  ,
  (
  select  SYSTEM_PROFILE_CODE
  ,PAYMENT_PROFILE_NAME
  ,BEP_ACCOUNT_ID
       ,RESET_VALUE_1    
       ,LAST_USED_NUMBER_1
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_1 is not null
   union   
    
   select  SYSTEM_PROFILE_CODE
   ,PAYMENT_PROFILE_NAME
     ,BEP_ACCOUNT_ID
       ,RESET_VALUE_2    
       ,LAST_USED_NUMBER_2
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_2 is not null
      
   union   
        select  SYSTEM_PROFILE_CODE
        ,PAYMENT_PROFILE_NAME
          ,BEP_ACCOUNT_ID
       ,RESET_VALUE_3    
       ,LAST_USED_NUMBER_3
      ,LAST_UPDATED_BY
      ,LAST_UPDATE_DATE
      ,CREATED_BY
      ,CREATION_DATE
      from   IBY_ACCT_PMT_PROFILES_VL  
      where RESET_VALUE_3 is not null
 
  )Detail
  ,IBY_BEPKEYS Account
WHERE IbySysPmtProfilesVl.SYSTEM_PROFILE_CODE         = PM.SYSTEM_PROFILE_CODE(+)
AND PaymentDocumentE0.PAYMENT_DOCUMENT_ID(+) = IbySysPmtProfilesVl.DEFAULT_PAYMENT_DOCUMENT_ID
AND   PM.SYSTEM_PROFILE_CODE =  Detail.SYSTEM_PROFILE_CODE
AND  Account.BEPID = IbySysPmtProfilesVl.BEPID
AND  Account.BEP_ACCOUNT_ID = Detail.BEP_ACCOUNT_ID
ORDER BY RES_SEQUENCES_IDENTIFIER