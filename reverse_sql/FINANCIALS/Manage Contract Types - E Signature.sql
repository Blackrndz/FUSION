/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Types%20-%20E%20Signature.sql $:
 * $Id: Manage Contract Types - E Signature.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS=OKC_CONTRACT_TYPES_VL
 
SELECT okcContactTPYEsEO.NAME  RES_NAME
,DECODE(okcContactTPYEsEO.ENABLE_ELECTRONIC_SIGN_FLAG,'Y','Yes','No') RES_ENABLE_ELECTRONIC_SIGNATUR
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcContactTPYEsEO.SOLUTION_PROVIDER_CODE
				AND LOOKUP_TYPE = 'OKC_ESIGN_PROVIDERS' ) RES_SOLUTION_PROVIDER
,DECODE(okcContactTPYEsEO.ESIGN_TEMPLATE_FLAG,'Y','Yes','No') RES_ENABLE_DOCUSIGN_TEMPLATE
,okcContactTPYEsEO.ESIGN_TEMPLATE_ID RES_DOCUSIGN_TEMPLATE
,okcContactTPYEsEO.EMAIL_SUBJECT RES_EMAIL_SUBJECT
,okcContactTPYEsEO.EMAIL_MESSAGE_TEXT RES_EMAIL_MESSAGE
,okcContactTPYEsEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcContactTPYEsEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcContactTPYEsEO.CREATED_BY RSC_CREATED_BY
,okcContactTPYEsEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_CONTRACT_TYPES_VL okcContactTPYEsEO
WHERE CONTRACT_TYPE_ID = CONTRACT_TYPE_ID
ORDER BY okcContactTPYEsEO.NAME


 






