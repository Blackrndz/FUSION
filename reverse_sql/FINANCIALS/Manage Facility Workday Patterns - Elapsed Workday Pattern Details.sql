/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT PatternEO.PATTERN_NAME RES_NAME
,PatternDetailEO.DAY_START_NUM RES_START_DAY
,PatternDetailEO.DAY_STOP_NUM RES_END_DAY
,ShiftEO.SHIFT_NAME RES_SHIFT_NAME
,PatternDetailEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,PatternDetailEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,PatternDetailEO.CREATED_BY  RSC_CREATED_BY
,PatternDetailEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM ZMM_SR_PATTERNS_VL PatternEO
,ZMM_SR_PATTERN_DTLS PatternDetailEO
,ZMM_SR_SHIFTS_VL ShiftEO
WHERE PatternEO.PATTERN_TYPE_CODE = 'ELAPSED'
AND PatternEO.PATTERN_ID = PatternDetailEO.PATTERN_ID
AND PatternDetailEO.CHILD_SHIFT_ID = ShiftEO.SHIFT_ID
ORDER BY PatternEO.PATTERN_NAME
,PatternDetailEO.DAY_START_NUM