/* ****************************************************************************
 * $Revision: 56510 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-07-06 09:21:36 +0700 (Wed, 06 Jul 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/Backup%20Trunk/reverse_sql/FINANCIALS/Manage%20Lifecycle%20Phases%20-%20Manage%20Lifecycle%20Phases.sql $:
 * $Id: Manage Lifecycle Phases - Lifecycle Phases.sql 56510 2016-07-06 02:21:36Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
select phaseseo.phase_seq 	RES_SEQUENCE
,phaseseo.phase_name 	RES_PHASE
,phaseseo.phase_code RES_PHASE_CODE
,lookuppeo.meaning res_phase_type
,to_char(phaseseo.start_date,'DD-Mon-YYYY') res_start_date
,TO_CHAR(phaseseo.end_date,'DD-Mon-YYYY') RES_END_DATE

,PhasesEO.last_updated_by  AS RSC_LAST_UPDATED_BY
,PhasesEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,PhasesEO.CREATED_BY  RSC_CREATED_BY
,PhasesEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM egp_phases_vl phaseseo
, fnd_lookups lookuppeo
WHERE lookuppeo.lookup_type = 'EGP_LIFECYCLE_PHASES'
AND phaseseo.phase_type     = lookuppeo.lookup_code

ORDER BY PhasesEO.PHASE_TYPE
,PhasesEO.PHASE_SEQ
