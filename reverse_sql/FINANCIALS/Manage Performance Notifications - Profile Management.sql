/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-03-17  $:
* $HeadURL: $:
* $Id: Manage Category Descriptive Flexfields - Context Segments $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT notisE0.NOTIF_LABEL RES_NOTIFICATION
,notisE0.DESCRIPTION RES_DESCRIPTION
,DECODE(notisE0.NOTIF_ENABLED,'Y','Yes','No') RES_ENABLED
,notisE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,notisE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,notisE0.CREATED_BY RSC_CREATED_BY
,notisE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,notisE0.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM HRT_NOTIF_SETUP_VL notisE0
WHERE notisE0.PRODUCT_CODE = 'HRT'
ORDER BY notisE0.NOTIF_LABEL