/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Contract%20Line%20Types%20-%20Contract%20Line%20Type.sql $:
 * $Id: Manage Contract Line Types - Contract Line Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 -- RSC_PREREQUISITE_OBJECTS=OKC_LINE_TYPES_VL
 
SELECT okcLineTypeEO.NAME RES_NAME
,okcLineTypeEO.DESCRIPTION RES_DESCRIPTION
,okcLineTypeEO.CLE_TYPE RES_CODE
,(SELECT MEANING FROM FND_LOOKUPS 
	WHERE LOOKUP_TYPE = 'OKC_LINE_TYPE_SOURCE'
		AND LOOKUP_CODE = okcLineTypeEO.SOURCE_CODE 
			) RES_SOURCE
,okcLineTypeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,okcLineTypeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,okcLineTypeEO.CREATED_BY RSC_CREATED_BY
,okcLineTypeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM OKC_LINE_TYPES_VL okcLineTypeEO
ORDER BY okcLineTypeEO.NAME 