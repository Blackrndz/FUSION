/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT gmsINSTITUE0.INSTITUTION_NAME RES_NAME
,(SELECT INSTITUTION_NAME
    FROM GMS_INSTITUTIONS_VL
    WHERE INSTITUTION_ID = gmsINSTITUE0.REPORTS_TO
    ) RES_PARENT_INSTITUTION
,gmsINSTITUE0.DESCRIPTION RES_DESCRIPTION
,gmsINSTITUE0.DUNS_NUMBER RES_D_U_N_S_NUMBER
,gmsINSTITUE0.NIH_IPF RES_NIH_IPF_NUMBER
,gmsINSTITUE0.DHHS_ENTITY_NUMBER RES_DHHS_ENTITY_NUMBER

,gmsINSTITUE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,gmsINSTITUE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,gmsINSTITUE0.CREATED_BY  RSC_CREATED_BY
,gmsINSTITUE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_INSTITUTIONS_VL gmsINSTITUE0
ORDER BY gmsINSTITUE0.INSTITUTION_NAME
