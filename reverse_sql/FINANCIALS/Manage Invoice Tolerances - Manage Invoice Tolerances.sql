/* ****************************************************************************
 * $Revision: 48966 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-26 12:14:00 +0700 (Wed, 26 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48966 2015-08-26 05:14:00Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT ApToleranceTemplates.TOLERANCE_NAME AS RES_NAME
,ApToleranceTemplates.DESCRIPTION          AS RES_DESCRIPTION
,(SELECT DISPLAYED_FIELD
	FROM AP_LOOKUP_CODES
	WHERE lookup_type = 'TOLERANCE TYPE'
	AND LOOKUP_CODE   = ApToleranceTemplates.TOLERANCE_TYPE
	) AS RES_TYPE
,ApToleranceTemplates.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,ApToleranceTemplates.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,ApToleranceTemplates.CREATED_BY  RSC_CREATED_BY
,ApToleranceTemplates.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM AP_TOLERANCE_TEMPLATES ApToleranceTemplates
ORDER BY ApToleranceTemplates.TOLERANCE_NAME
