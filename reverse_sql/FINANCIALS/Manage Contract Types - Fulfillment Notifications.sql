/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Types%20-%20Fulfillment%20Notifications.sql $:
 * $Id: Manage Contract Types - Fulfillment Notifications.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT okcContactTPYEsEO.NAME  RES_NAME
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcDTSnotiEO.NOTIFICATION_TYPE_CODE
				AND LOOKUP_TYPE = 'OKC_DTS_AGRMNT_NTF_TYPE' ) RES_NOTIFICATION_TYPE
,okcDTSnotiEO.DURATION RES_DURATION
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcDTSnotiEO.PERIOD_CODE
				AND LOOKUP_TYPE = 'OKC_DTS_TIME_PERIOD' ) RES_PERIOD
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcDTSnotiEO.RECIPIENT_ROLE_CODE
				AND LOOKUP_TYPE = 'OKC_PARTY_CONTACT_ROLE' ) RES_RECIPIENT_ROLE
,okcDTSnotiEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcDTSnotiEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcDTSnotiEO.CREATED_BY RSC_CREATED_BY
,okcDTSnotiEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_CONTRACT_TYPES_VL okcContactTPYEsEO
,OKC_DTS_NOTIFICATIONS okcDTSnotiEO
WHERE okcContactTPYEsEO.CONTRACT_TYPE_ID = okcDTSnotiEO.SOURCE_OBJECT_ID
ORDER BY okcContactTPYEsEO.NAME





