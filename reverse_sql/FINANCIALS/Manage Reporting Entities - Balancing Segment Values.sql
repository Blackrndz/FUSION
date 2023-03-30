/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Reporting%20Entities%20-%20Balancing%20Segment%20Values.sql $:
 * $Id: Manage Reporting Entities - Balancing Segment Values.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT  BUSINESSUNITPEO.BU_NAME 						RES_BUSINESS_UNIT
,REPORTINGENTITYHEADEREO.ENTITY_NAME RES_NAME
,APREPORTINGENTITYLINESALL.BALANCING_SEGMENT_VALUE RES_PRIMARY_BALANCING_SEGMENT_
,	(SELECT  fnd_val.description description
	FROM fnd_segment_attribute_values fnd_seg
	, ap_system_parameters_all ap
	, gl_sets_of_books gl
	, fnd_id_flex_segments fnd_id
	, fnd_flex_value_sets fnd_val_sets
	, FND_FLEX_VALUES_VL FND_VAL
	WHERE ap.org_id                    = APREPORTINGENTITYLINESALL.org_id
	AND gl.set_of_books_id             = ap.set_of_books_id
	AND fnd_seg.attribute_value        = 'Y'
	AND fnd_seg.segment_attribute_type = 'GL_BALANCING'
	AND fnd_seg.id_flex_code           = 'GL#'
	AND fnd_seg.id_flex_num            = gl.chart_of_accounts_id
	AND fnd_id.id_flex_code            = 'GL#'
	AND fnd_id.id_flex_num             = fnd_seg.id_flex_num
	AND fnd_id.application_column_name = fnd_seg.application_column_name
	AND fnd_id.flex_value_set_id       = fnd_val_sets.flex_value_set_id
	AND FND_VAL_SETS.FLEX_VALUE_SET_ID = FND_VAL.FLEX_VALUE_SET_ID
	and fnd_val.flex_value  = APREPORTINGENTITYLINESALL.BALANCING_SEGMENT_VALUE
	)  RES_DESCRIPTION
,APREPORTINGENTITYLINESALL.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,APREPORTINGENTITYLINESALL.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,APREPORTINGENTITYLINESALL.CREATED_BY  RSC_CREATED_BY
,APREPORTINGENTITYLINESALL.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,BusinessUnitPEO.BU_ID RSC_BUSINESS_UNIT_ID
,BusinessUnitPEO.LEGAL_ENTITY_ID RSC_LEGAL_ENTITY_ID
,APREPORTINGENTITYLINESALL.ORG_ID RSC_ORGANIZATION_ID
,BusinessUnitPEO.BUSINESS_GROUP_ID RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from FUSION.FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
,AP_REPORTING_ENTITIES_ALL REPORTINGENTITYHEADEREO
,AP_REPORTING_ENTITY_LINES_ALL APREPORTINGENTITYLINESALL
WHERE BUSINESSUNITPEO.BU_ID = REPORTINGENTITYHEADEREO.ORG_ID
and REPORTINGENTITYHEADEREO.TAX_ENTITY_ID = APREPORTINGENTITYLINESALL.TAX_ENTITY_ID
ORDER BY BUSINESSUNITPEO.BU_NAME,REPORTINGENTITYHEADEREO.ENTITY_NAME ,ApReportingEntityLinesAll.BALANCING_SEGMENT_VALUE