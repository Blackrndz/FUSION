/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- REPLACE_HTML_KEYWORD = RES_COMMENTS

 
SELECT gmsINSTITUE0.INSTITUTION_NAME RES_NAME
,gmsREFE0.REFERENCE_NAME RES_TYPE
,gmsINSTITUREFE0.VALUE RES_VALUE
,gmsREFE0.DESCRIPTION RES_DESCRIPTION
,REPLACE(REPLACE(REPLACE(gmsINSTITUREFE0.COMMENTS,'&','#AMP#'),'<','#OPENTAG#'),'>','#CLOSETAG#') RES_COMMENTS

,gmsINSTITUREFE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,gmsINSTITUREFE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,gmsINSTITUREFE0.CREATED_BY  RSC_CREATED_BY
,gmsINSTITUREFE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_INSTITUTIONS_VL gmsINSTITUE0
,GMS_INSTN_REFERENCES_VL gmsINSTITUREFE0
,GMS_REFERENCES_VL gmsREFE0
WHERE gmsINSTITUE0.INSTITUTION_ID = gmsINSTITUREFE0.INSTITUTION_ID
AND gmsINSTITUREFE0.REFERENCE_ID = gmsREFE0.REFERENCE_ID
ORDER BY gmsINSTITUE0.INSTITUTION_NAME
,gmsREFE0.REFERENCE_NAME
