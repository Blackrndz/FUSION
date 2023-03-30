/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Profile%20Content%20Types%20-%20Subscribers.sql $:
 * $Id: Manage Profile Content Types - Subscribers.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT hrtContentTypeEO.CONTEXT_NAME RES_CONTEXT_NAME 
 ,hrtContentTypeEO.CONTENT_TYPE_NAME RES_NAME
 ,hrSourceVLEO.SOURCE_CODE RES_CODE
 ,hrSourceVLEO.SOURCE_DESCRIPTION RES_SUBSCRIBER_NAME
 ,hrtContentSourceRlatEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
 ,hrtContentSourceRlatEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
 ,hrtContentSourceRlatEO.CREATED_BY RSC_CREATED_BY
 ,hrtContentSourceRlatEO.CREATION_DATE RSC_CREATION_DATE
 ,NULL RSC_LEDGER_ID
 ,NULL RSC_CHART_OF_ACCOUNTS_ID
 ,NULL RSC_BUSINESS_UNIT_ID
 ,NULL RSC_LEGAL_ENTITY_ID
 ,NULL RSC_ORGANIZATION_ID
 ,hrtContentSourceRlatEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
 ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_CONTENT_TYPES_VL hrtContentTypeEO
,HRT_CONTENT_SOURCE_RLATS hrtContentSourceRlatEO
,HRT_SOURCES_VL hrSourceVLEO
WHERE hrtContentTypeEO.CONTENT_TYPE_ID = hrtContentSourceRlatEO.CONTENT_TYPE_ID
AND hrtContentSourceRlatEO.SOURCE_ID = hrSourceVLEO.SOURCE_ID(+)
AND hrtContentTypeEO.BUSINESS_GROUP_ID = hrtContentSourceRlatEO.BUSINESS_GROUP_ID
AND hrSourceVLEO.BUSINESS_GROUP_ID = hrtContentSourceRlatEO.BUSINESS_GROUP_ID
ORDER BY hrtContentTypeEO.CONTENT_TYPE_NAME
