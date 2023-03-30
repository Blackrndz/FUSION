/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Banks%20-%20Banks.sql $:
* $Id: Manage Banks - Banks.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT BankEO.COUNTRY_NAME      AS RES_COUNTRY
,BankEO.BANK_NAME               AS RES_BANK_NAME
,BankEO.BANK_NAME_ALT           AS RES_ALTERNATE_BANK_NAME
,BankEO.BANK_NUMBER             AS RES_BANK_CODE
,BankEO.DESCRIPTION             AS RES_DESCRIPTION
,BankEO.TAXPAYER_ID             AS RES_TAXPAYER_ID
,BankEO.TAX_REGISTRATION_NUMBER AS RES_TAX_REGISTRATION_NUMBER
,BankEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,BankEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,BankEO.CREATED_BY RSC_CREATED_BY
,BankEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CE_BANKS_V BankEO
ORDER BY RES_COUNTRY
,RES_BANK_NAME