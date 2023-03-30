/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Goal%20Management%20Notification%20Settings%20-%20Goal%20Management.sql $:
 * $Id: Manage Goal Management Notification Settings - Goal Management.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT hrtNOTIFSETEO.NOTIF_LABEL RES_NOTIFICATION
,hrtNOTIFSETEO.DESCRIPTION RES_DESCRIPTION
,DECODE(hrtNOTIFSETEO.NOTIF_ENABLED,'Y','Yes','No') RES_ENABLED
,hrtNOTIFSETEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrtNOTIFSETEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrtNOTIFSETEO.CREATED_BY RSC_CREATED_BY
,hrtNOTIFSETEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_NOTIF_SETUP_VL hrtNOTIFSETEO
WHERE PRODUCT_CODE = 'HRG'
ORDER BY RES_ENABLED,RES_NOTIFICATION
