/* ****************************************************************************
 * $Revision: 58428 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-09-23 18:27:01 +0700 (Fri, 23 Sep 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Units%20of%20Measure%20Profiles%20-%20Profile%20Values.sql $:
 * $Id: Manage Units of Measure Profiles - Profile Values.sql 58428 2016-09-23 11:27:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT hrtSOURCEO.SOURCE_CODE RES_CODE
,hrtSOURCEO.SOURCE_DESCRIPTION RES_SUBSCRIBER

,hrtSOURCEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hrtSOURCEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hrtSOURCEO.CREATED_BY RSC_CREATED_BY
,hrtSOURCEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRT_SOURCES_VL hrtSOURCEO
WHERE hrtSOURCEO.SOURCE_CODE IN ('IRC','HRA','RM','HRMS','TM','TALEO','WLFLM','HRG','CDEV')
ORDER BY hrtSOURCEO.SOURCE_ID 