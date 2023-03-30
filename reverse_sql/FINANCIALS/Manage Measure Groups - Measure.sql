/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_MEASURE_GROUPS_VL
 
SELECT MeasureGroupsE0.NAME RES_NAME
,'' RES_AVAILABLE_MEASURES
,MeasuresE0.NAME RES_SELECTED_MEASURES
,MeasureGroupAssignE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,MeasureGroupAssignE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,MeasureGroupAssignE0.CREATED_BY  RSC_CREATED_BY
,MeasureGroupAssignE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_MEASURE_GROUPS_VL MeasureGroupsE0
,MSC_MEASURE_GROUP_ASSIGN MeasureGroupAssignE0
,MSC_MEASURES_VL MeasuresE0
WHERE MeasureGroupsE0.GROUP_ID = MeasureGroupAssignE0.GROUP_ID
AND MeasureGroupAssignE0.MEASURE_ID = MeasuresE0.MEASURE_ID
ORDER BY MeasureGroupsE0.NAME