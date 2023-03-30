/* ****************************************************************************
* $Revision: 55391 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-05-24 15:07:24 +0700 (Tue, 24 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Asset%20Categories%20-%20Accounts.sql $:
* $Id: Manage Asset Categories - Accounts.sql 55391 2016-05-24 08:07:24Z dhara.pithadiya $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT ItemAttributeEO.ATTR_GROUP_DISP_NAME RES_ATTRIBUTE_GROUP
,ItemAttributeEO.ATTR_DISP_NAME RES_ATTRIBUTE
,LookupPEO.MEANING RES_CONTROLLED_AT
,ItemAttributeEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ItemAttributeEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ItemAttributeEO.CREATED_BY RSC_CREATED_BY
,ItemAttributeEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EGP_ITEM_ATTRIBUTES_VL ItemAttributeEO
,FND_LOOKUPS LookupPEO
WHERE(LookupPEO.LOOKUP_TYPE                = 'EGP_ORG_CONTROL_CODES')
AND(NVL(ItemAttributeEO.CONTROL_LEVEL,'M') = LookupPEO.LOOKUP_CODE)
AND(ItemAttributeEO.CONTROL_LEVEL          = 'M'
OR ItemAttributeEO.CONTROL_LEVEL           = 'C')
ORDER BY ItemAttributeEO.ATTR_GROUP_DISP_NAME
,ItemAttributeEO.ATTR_DISP_NAME