/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Types%20-%20Additional%20Party%20Roles.sql $:
 * $Id: Manage Contract Types - Additional Party Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT okcContactTPYEsEO.NAME  RES_NAME
,(SELECT MEANING FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcContactTPYEsPartiesEO.PARTY_ROLE_CODE
				AND LOOKUP_TYPE = 'OKC_PARTY_ROLE' ) RES_ROLE
,(SELECT DESCRIPTION FROM FND_LOOKUPS 
			WHERE LOOKUP_CODE = okcContactTPYEsPartiesEO.PARTY_ROLE_CODE
				AND LOOKUP_TYPE = 'OKC_PARTY_ROLE' ) RES_DESCRIPTION
,DECODE(okcContactTPYEsPartiesEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,okcContactTPYEsPartiesEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcContactTPYEsPartiesEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcContactTPYEsPartiesEO.CREATED_BY RSC_CREATED_BY
,okcContactTPYEsPartiesEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_CONTRACT_TYPES_VL okcContactTPYEsEO
,OKC_CONTRACT_TYPE_PARTIES okcContactTPYEsPartiesEO
WHERE okcContactTPYEsEO.CONTRACT_TYPE_ID = okcContactTPYEsPartiesEO.CONTRACT_TYPE_ID
AND okcContactTPYEsPartiesEO.INTERNAL_ROLE_FLAG = 'N' 
AND okcContactTPYEsPartiesEO.EXTERNAL_ROLE_FLAG = 'N'
ORDER BY okcContactTPYEsEO.NAME


