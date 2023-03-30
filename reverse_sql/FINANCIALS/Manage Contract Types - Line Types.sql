/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Types%20-%20Line%20Types.sql $:
 * $Id: Manage Contract Types - Line Types.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 
SELECT okcContactTPYEsEO.NAME  RES_NAME
,okcLineTPYEsEO.NAME  RES_NAME_LINE_TYPE
,okcLineTPYEsEO.DESCRIPTION  RES_DESCRIPTION
,DECODE(okcContactTPYEsLineEO.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,okcContactTPYEsLineEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcContactTPYEsLineEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcContactTPYEsLineEO.CREATED_BY RSC_CREATED_BY
,okcContactTPYEsLineEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_CONTRACT_TYPES_VL okcContactTPYEsEO
,OKC_CONTRACT_TYPE_LINES okcContactTPYEsLineEO
,OKC_LINE_TYPES_VL okcLineTPYEsEO
WHERE okcContactTPYEsEO.CONTRACT_TYPE_ID = okcContactTPYEsLineEO.CONTRACT_TYPE_ID
AND okcContactTPYEsLineEO.LINE_TYPE_ID = okcLineTPYEsEO.LINE_TYPE_ID
ORDER BY okcContactTPYEsEO.NAME


